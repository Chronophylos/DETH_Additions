# Auto-flag Rebel Vehicles Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Apply the configured flag automatically to rebel vehicles the moment Antistasi spawns them, instead of requiring a player to use the ACE action on each one.

**Architecture:** Antistasi Ultimate fires an `AIVehInit` event at the end of `A3A_fnc_AIVEHinit` with `[_vehicle, _side]`. Every rebel vehicle source — garage placement, black-market purchases (which route through the garage pool), and AI/recruited garrison vehicles — passes through that function. The `flags` addon registers one listener on that event, filters to `teamPlayer` vehicles of the classes it already supports, and calls its existing `applyFlag` function. `applyFlag` already forwards from client to server, so no new networking is needed.

**Tech Stack:** Arma 3 SQF, CBA_A3 macros and settings framework, ACE3-style addon layout (the `#include "script_component.hpp"` / `PREP` / `GVAR` conventions already used throughout `addons/flags`).

## Status

**Task 1 is complete and committed** (`bdb72eb`, branch `feat/auto-flag-rebel-vehicles`).
`hemtt check` and `hemtt build` both pass with nothing reported in `addons/flags`;
the remaining warnings are pre-existing in `statistics`, `main`, and `utils`.

**Task 2 ran in-game on 2026-07-28** against Antistasi Ultimate 3020755032 in a
local session. Step 4 passes: a garage spawn reaches `handleVehicleInit` and
`applyFlag` in the same frame, which also settles the Step 10 timing question in
favour of direct registration.

Steps 1–4, 6, 8, 9, 10 and 11 pass. Two steps are **unverified**:

- **Step 5 (multiplayer visibility)** — no second machine or headless client was
  available. The client-to-server hop is exercised by `applyFlag`'s existing
  `CBA_fnc_serverEvent` path, which the ACE action already used before this
  change, so the risk is low but it has not been observed.
- **Step 7 (AI-created rebel vehicle)** — impractical to trigger on demand. These
  paths call `A3A_fnc_AIVEHinit` with `teamPlayer` exactly like the verified
  garage path.

Note for future debugging: `handleVehicleInit` exits at the `autoFlag` check
before its first `TRACE`, so "setting is off" and "listener never registered"
produce identical (empty) logs. Confirm the setting is on before investigating
the event wiring.

## Global Constraints

- Prefix is `DTA`, component is `flags`; `GVAR(x)` resolves to `DTA_flags_x` and `FUNC(x)` to `DTA_flags_fnc_x`. Never write these names out longhand — always use the macros.
- Every `.sqf` file in `addons/flags/functions/` starts with `#include "script_component.hpp"`.
- Every new function file needs a matching `PREP(name);` line in `addons/flags/XEH_PREP.hpp`, or it will not be compiled and calls to it will silently fail.
- Every user-visible string goes in `addons/flags/stringtable.xml` under the existing `<Container name="Flags">`, referenced from SQF via `LLSTRING(key)`.
- New CBA settings in this addon use `isGlobal = 2` (server-forced), matching `useFactionFlag`, `flagTexture`, and `vehicleColor`.
- There is no automated test harness in this repository. Arma SQF is only verifiable by loading the mod in-game. "Tests" in this plan mean the manual in-game checklist in Task 2 plus a static syntax check.
- Commit messages follow Conventional Commits (`feat:`, `fix:`, `docs:`, `chore:`) — the changelog is generated from them by `conventional-changelog-cli`. Do **not** hand-edit `CHANGELOG.md`.

---

## File Structure

| File | Change | Responsibility |
|---|---|---|
| `addons/flags/stringtable.xml` | Modify | Display name and tooltip for the new setting |
| `addons/flags/initSettings.inc.sqf` | Modify | Declare the `autoFlag` CBA setting |
| `addons/flags/functions/fnc_handleVehicleInit.sqf` | Create | Decide whether a newly initialized vehicle should be flagged |
| `addons/flags/XEH_PREP.hpp` | Modify | Register the new function for compilation |
| `addons/flags/XEH_postInit.sqf` | Modify | Subscribe to Antistasi's `AIVehInit` event |

The decision logic lives in its own function rather than inline in `XEH_postInit.sqf` so it is PREP'd (and therefore recompilable in dev builds) and readable on its own, matching how `handleVehicleKilled` is structured.

---

### Task 1: Auto-flag setting and event listener

Everything in this task is required for any of it to have an effect: without the setting the handler cannot be enabled, without the handler the listener has nothing to call, without the listener nothing runs. It ships as one reviewable change.

**Files:**
- Modify: `addons/flags/stringtable.xml` (inside `<Container name="Flags">`)
- Modify: `addons/flags/initSettings.inc.sqf` (append a fourth setting block)
- Create: `addons/flags/functions/fnc_handleVehicleInit.sqf`
- Modify: `addons/flags/XEH_PREP.hpp`
- Modify: `addons/flags/XEH_postInit.sqf`

**Interfaces:**
- Consumes: `FUNC(applyFlag)` — takes `[_vehicle]`, applies the resolved flag texture, forwards to the server when called on a client. Defined in `addons/flags/functions/fnc_applyFlag.sqf`.
- Consumes: `A3A_Events_fnc_addEventListener` — Antistasi Ultimate. Signature `[_eventType, _listenerId, _function] call A3A_Events_fnc_addEventListener`, where `_eventType` is a class name under `configFile >> "A3A" >> "Events"`, `_listenerId` is a unique string, and `_function` is code. The `AIVehInit` event passes `[_vehicle, _side]`.
- Consumes: `teamPlayer` — Antistasi's global holding the rebel side.
- Produces: `GVAR(autoFlag)` (Boolean setting) and `FUNC(handleVehicleInit)` (takes `[_vehicle, _side]`, returns nothing).

- [x] **Step 1: Add the stringtable keys**

In `addons/flags/stringtable.xml`, inside `<Container name="Flags">`. That container lists the ACE action strings first, then the setting strings alphabetically by setting name (`flagTexture_*`, then `useFactionFlag_*`), so insert these immediately **before** the `STR_DTA_Flags_flagTexture_Description` key:

```xml
            <Key ID="STR_DTA_Flags_autoFlag_Description">
                <English>Automatically apply the flag to rebel vehicles when they are spawned from the garage, bought, or created by Antistasi. Only affects vehicles spawned after this is enabled; use the ACE action on vehicles that already exist.</English>
            </Key>
            <Key ID="STR_DTA_Flags_autoFlag_DisplayName">
                <English>Auto Flag Rebel Vehicles</English>
            </Key>
```

- [x] **Step 2: Add the CBA setting**

Append to `addons/flags/initSettings.inc.sqf`:

```sqf
[
    QGVAR(autoFlag), // setting
    "CHECKBOX", // type
    [LLSTRING(autoFlag_DisplayName), LLSTRING(autoFlag_Description)], // display name and tooltip
    format ["DETH %1", LLSTRING(DisplayName)], // category
    false, // default value
    2 // isGlobal
] call CBA_fnc_addSetting;
```

There is deliberately no change callback. Toggling the setting affects vehicles spawned afterwards; existing vehicles are handled by the ACE action and `refreshFlags`.

- [x] **Step 3: Create the handler function**

Create `addons/flags/functions/fnc_handleVehicleInit.sqf`:

```sqf
#include "script_component.hpp"
/*
 * Author: Chronophylos
 * Flags a newly initialized rebel vehicle when the auto flag setting is on.
 * Hooked to Antistasi's AIVehInit event, which fires for every vehicle that
 * passes through A3A_fnc_AIVEHinit: garage placements, bought vehicles, and
 * AI-created rebel vehicles.
 *
 * The event is local to whichever machine spawned the vehicle, usually a
 * client. applyFlag forwards to the server, so the server stays the single
 * writer.
 *
 * Arguments:
 * 0: Vehicle <OBJECT>
 * 1: Side <SIDE>
 *
 * Return Value:
 * None
 *
 * Example:
 * [_vehicle, teamPlayer] call DTA_flags_fnc_handleVehicleInit
 */

params ["_vehicle", "_side"];

if (!GVAR(autoFlag)) exitWith {};

if (isNull _vehicle) exitWith {
    TRACE_1("handleVehicleInit called with invalid vehicle",_vehicle);
};

// teamPlayer is Antistasi's rebel side; enemy and civilian vehicles stay unflagged
if (_side isNotEqualTo teamPlayer) exitWith {};

// same classes the ACE actions and the killed handler cover, which keeps
// statics, crates and other AIVehInit subjects out
private _isVehicle = _vehicle isKindOf "Car"
    || {_vehicle isKindOf "Tank"}
    || {_vehicle isKindOf "Helicopter"}
    || {_vehicle isKindOf "Plane"}
    || {_vehicle isKindOf "Ship_F"};

if (!_isVehicle) exitWith {
    TRACE_1("Not a flaggable vehicle",_vehicle);
};

TRACE_2("Auto flagging vehicle",_vehicle,_side);

[_vehicle] call FUNC(applyFlag);
```

- [x] **Step 4: Register the function for compilation**

Append to `addons/flags/XEH_PREP.hpp`:

```
PREP(handleVehicleInit);
```

- [x] **Step 5: Subscribe to the Antistasi event**

Append to `addons/flags/XEH_postInit.sqf`:

```sqf
// Antistasi fires AIVehInit at the end of A3A_fnc_AIVEHinit for every vehicle
// it creates. The event is declared isLocal, so every machine registers and
// each one handles the vehicles it spawned itself. Guarded so the addon stays
// inert outside Antistasi Ultimate.
if (isNil "A3A_Events_fnc_addEventListener") exitWith {
    TRACE_1("Antistasi event system not available, skipping auto flag listener",QUOTE(ADDON));
};

["AIVehInit", QUOTE(ADDON), LINKFUNC(handleVehicleInit)] call A3A_Events_fnc_addEventListener;
```

`QUOTE(ADDON)` expands to the string `"DTA_flags"`, which serves as the unique listener id Antistasi requires.

Because this uses `exitWith`, it must be the **last** block in the file. Verify nothing follows it after the edit.

- [x] **Step 6: Lint and build**

HEMTT lints the SQF, validates the configs, and parses the stringtable, which
covers what this step and Step 7 were originally going to do by hand:

```bash
cd /home/chrono/Projects/DETH_Additions
hemtt check
hemtt build
```

Expected: both exit 0, and nothing in the output points at `addons/flags`.
Pre-existing warnings in `addons/statistics`, `addons/main` and `addons/utils`
(`L-S12`, `FNL`, `INVALID-PBOPREFIX`, `L-C14`) are unrelated to this change and
should be left alone.

- [x] **Step 7: Confirm the wiring**

```bash
cd /home/chrono/Projects/DETH_Additions
grep -n handleVehicleInit addons/flags/XEH_PREP.hpp
grep -n autoFlag addons/flags/initSettings.inc.sqf addons/flags/stringtable.xml
grep -n AIVehInit addons/flags/XEH_postInit.sqf
ls .hemttout/build/addons/dta_flags.pbo
```

Expected: every grep returns matches and the PBO exists.

- [x] **Step 8: Commit**

```bash
cd /home/chrono/Projects/DETH_Additions
git add addons/flags/stringtable.xml addons/flags/initSettings.inc.sqf \
        addons/flags/functions/fnc_handleVehicleInit.sqf \
        addons/flags/XEH_PREP.hpp addons/flags/XEH_postInit.sqf
git commit -m "feat(flags): auto apply flags to rebel vehicles on spawn

Hooks Antistasi's AIVehInit event so garage, shop and AI-created rebel
vehicles get the configured flag without a manual ACE action. Off by
default behind the new Auto Flag Rebel Vehicles setting."
```

---

### Task 2: In-game verification

This task changes no files. HEMTT confirms the code compiles and lints, but it cannot tell you whether Antistasi's event actually reaches the listener — the only real test is loading the mod in Arma 3 with Antistasi Ultimate.

**Requires a machine with Arma 3 installed.** Task 1 was implemented on a machine without it.

**Files:** none.

**Interfaces:**
- Consumes: the built `DTA_flags` addon from Task 1, loaded alongside CBA_A3, ACE3 and Antistasi Ultimate.

- [x] **Step 1: Build and load**

```bash
git fetch origin && git checkout feat/auto-flag-rebel-vehicles
hemtt launch antistasi
```

The `antistasi` preset in `.hemtt/launch.toml` already pulls CBA_A3 (450814997), ACE3 (463939057) and Antistasi Ultimate (3020755032) from the workshop and loads the dev build of this mod.

Start an Antistasi Ultimate campaign and confirm the addon initialized: the RPT log has no `DTA_flags` errors and **DETH Flags** appears in the CBA addon options.

- [x] **Step 2: Confirm the setting exists and defaults to off**

In CBA Addon Options → **DETH Flags**, confirm **Auto Flag Rebel Vehicles** is present, has the tooltip text from Step 1 of Task 1, and is unchecked.

- [x] **Step 3: Baseline — setting off**

With the setting off, spawn a vehicle from the garage.
Expected: no flag on the vehicle. The ACE **Add Flag** action still works manually.

Result: passed. A bought vehicle and a garage vehicle both spawned unflagged, and
the manual ACE action still applied a flag (`fnc_applyFlag.sqf:34` in the RPT).

- [x] **Step 4: Setting on, garage spawn**

Enable **Auto Flag Rebel Vehicles**. Spawn a vehicle from the garage.
Expected: the vehicle carries the texture from the **Flag Texture** setting, with no player interaction.

Result: passed, twice. RPT:

```
16:22:51 Auto flagging vehicle: C_Offroad_01_F, _side=GUER  fnc_handleVehicleInit.sqf:47
16:22:51 Applying flag: C_Offroad_01_F, _texture=a3\data_f\flags\flag_fia_co.paa  fnc_applyFlag.sqf:34
```

- [ ] **Step 5: Multiplayer visibility** — UNVERIFIED, no second machine available

With a second machine (or a headless client / dedicated server plus one client) connected, have a *client* place a vehicle from the garage.
Expected: the flag is visible on both machines. This is the check that the local `AIVehInit` event correctly reached the server through `applyFlag`.

Not run. Re-test this before relying on the feature in a multiplayer campaign.

- [x] **Step 6: Faction flag interaction**

Enable **Use Faction Flag** as well and spawn another vehicle.
Expected: the new vehicle carries the rebel faction's flag rather than the configured texture path.

Result: passed, tested in both directions. With **Use Faction Flag** on, auto-flagged
vehicles got `flag_fia_co.paa`; turning it off re-textured the two already
auto-flagged vehicles via `refreshFlags` (`count _flagged=2`) and the next garage
spawn used the configured `flag_ion_CO.paa`. Both branches of `getFlagTexture`
are covered.

- [ ] **Step 7: AI-created rebel vehicle** — UNVERIFIED, impractical to trigger on demand

Trigger a rebel garrison or squad that spawns with a vehicle (for example recruit a squad with a vehicle, or find an AI rebel patrol vehicle).
Expected: it carries the flag too.

Not run. Low risk: these paths call `A3A_fnc_AIVEHinit` with `teamPlayer` exactly
like the garage path that Step 4 verified, so they reach the same listener.

- [x] **Step 8: Enemy vehicles unaffected**

Observe or spawn an enemy (non-`teamPlayer`) vehicle.
Expected: no flag.

Result: passed, verified directly rather than by observation. Calling
`[_offroad, east] call DTA_flags_fnc_handleVehicleInit` produced no
`Auto flagging` and no `Applying flag`. An offroad is a `Car`, so it clears the
class filter — only the side check could have rejected it.

- [x] **Step 9: Statics and crates unaffected**

Place a static weapon or an ammo crate through Antistasi.
Expected: no errors in the RPT and no attempt to flag them. The class filter should have excluded them.

Result: passed, and worth recording *why*, because the two object types fail for
different reasons:

- **Crates never reach us at all.** `A3A_fnc_AIVEHinit` exits at
  `if (fullCrew [_veh, "", true] isEqualTo []) exitWith` (fn_AIVEHinit.sqf:19)
  before firing the event, so a crewless object never triggers `AIVehInit`. Our
  class filter is not what stops them.
- **Statics do reach us and are rejected by the class filter.**
  `[_mortar, teamPlayer] call DTA_flags_fnc_handleVehicleInit` on a
  `B_G_Mortar_01_F` logged `Not a flaggable vehicle`
  (`fnc_handleVehicleInit.sqf:44`) and applied nothing.

No script errors in the RPT throughout.

- [x] **Step 10: Record the registration-timing result**

The design flagged one unverified assumption: whether `A3A_Events_fnc_addEventListener` is defined by the time this addon's postInit runs. Step 4 passing proves it is.

Result: direct registration works. The guard never tripped and no
`Antistasi event system not available` trace appeared, so the
`CBA_fnc_waitUntilAndExecute` fallback below was not needed and is left unused.

If Step 4 fails **and** the RPT shows the `Antistasi event system not available` trace from Task 1 Step 5, the ordering assumption was wrong. Fix it by replacing the guard block in `addons/flags/XEH_postInit.sqf` with:

```sqf
// Antistasi's function library may not be compiled when our postInit runs, so
// wait for the event system before registering.
[
    {!isNil "A3A_Events_fnc_addEventListener"},
    {
        ["AIVehInit", QUOTE(ADDON), LINKFUNC(handleVehicleInit)] call A3A_Events_fnc_addEventListener;
    },
    []
] call CBA_fnc_waitUntilAndExecute;
```

Then re-run Steps 4 through 9 and commit with `fix(flags): wait for Antistasi event system before registering listener`.

- [x] **Step 11: Update the design doc**

Edit `docs/superpowers/specs/2026-07-28-auto-flag-rebel-vehicles-design.md` and replace the "Registration timing is unverified" bullet under **Accepted limitations** with what actually happened — either that the direct registration works, or that the `waitUntilAndExecute` fallback was needed.

```bash
cd /home/chrono/Projects/DETH_Additions
git add docs/superpowers/specs/2026-07-28-auto-flag-rebel-vehicles-design.md
git commit -m "docs: record verified registration timing for auto flag listener"
```

---

## Out of Scope

Per the design document, none of the following are part of this plan:

- Auto-applying the configured `vehicleColor` texture to new vehicles.
- Flagging statics, crates, or other non-vehicle `AIVehInit` subjects.
- Re-flagging vehicles that already existed when the setting was switched on.
- Remembering a manual flag reset so a vehicle is not re-flagged on re-init.
