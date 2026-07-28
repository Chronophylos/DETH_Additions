# Auto-flag rebel vehicles

## Problem

Flags currently have to be added by hand, per vehicle, through the ACE action
added by the `flags` addon. Rebel vehicles come out of the garage and the black
market constantly, so every new vehicle is a manual step.

## Goal

When a rebel vehicle is spawned — from the garage, from the shop, or by
Antistasi's own AI/recruitment code — it gets the configured flag applied
automatically, without a player touching it.

## How Antistasi exposes this

Antistasi Ultimate has an event registry at `A3A/addons/events/Events.hpp`.
`A3A_fnc_AIVEHinit` fires the `AIVehInit` event as its last action
(`A3A/addons/core/functions/CREATE/fn_AIVEHinit.sqf:293`) with arguments
`[_veh, _side]`.

Every rebel vehicle path reaches it:

- Garage placement calls `HR_GRG_fnc_vehInit`
  (`A3A/addons/garage/Public/config.inc:87`), which calls
  `[_this, TeamPlayer] call A3A_fnc_AIVEHinit`.
- Bought vehicles (`fn_addBlackMarketVeh.sqf`) are added to the garage pool
  rather than spawned directly, so they reach the world through the garage path
  above.
- AI and recruited rebel vehicles (`fn_createSDKgarrisons.sqf`,
  `fn_addFIAsquadHC.sqf`) call `A3A_fnc_AIVEHinit` with `teamPlayer` directly.

One listener on `AIVehInit` therefore covers every source. The event is declared
`isLocal = 1`, so it fires on whichever machine ran `AIVEHinit` — usually the
client that placed the vehicle.

## Design

### Setting

A new CBA setting in `addons/flags/initSettings.inc.sqf`:

```sqf
[
    QGVAR(autoFlag),
    "CHECKBOX",
    [LLSTRING(autoFlag_DisplayName), LLSTRING(autoFlag_Description)],
    format ["DETH %1", LLSTRING(DisplayName)],
    false,
    2 // isGlobal, matching the other flag settings
] call CBA_fnc_addSetting;
```

Default off, global, no change callback. Enabling it affects vehicles spawned
from that point on; existing vehicles are covered by the ACE action and
`refreshFlags`.

Stringtable keys `STR_DTA_Flags_autoFlag_DisplayName` and
`STR_DTA_Flags_autoFlag_Description` go in the existing `Flags` container.

### Handler

New function `addons/flags/functions/fnc_handleVehicleInit.sqf`, PREP'd in
`XEH_PREP.hpp`:

```sqf
params ["_veh", "_side"];

if (!GVAR(autoFlag)) exitWith {};
if (_side isNotEqualTo teamPlayer) exitWith {};
if !(_veh isKindOf "Car" || {_veh isKindOf "Tank"} || {_veh isKindOf "Helicopter"}
     || {_veh isKindOf "Plane"} || {_veh isKindOf "Ship_F"}) exitWith {};

[_veh] call FUNC(applyFlag);
```

The class filter matches the classes the ACE action and the `Killed` event
handler already cover, which keeps statics, crates and other `AIVEHinit`
subjects out.

### Registration

In `addons/flags/XEH_postInit.sqf`, guarded so the addon stays inert on
non-Antistasi missions and on Antistasi builds without the events addon:

```sqf
if (!isNil "A3A_Events_fnc_addEventListener") then {
    ["AIVehInit", QUOTE(ADDON), LINKFUNC(handleVehicleInit)] call A3A_Events_fnc_addEventListener;
};
```

`A3A_Events_fnc_addEventListener` takes `[event type, unique listener id,
function]`.

The listener registers on every machine, because the event is local to whichever
machine spawned the vehicle.

## What this reuses

- `applyFlag` already forwards client requests to the server via
  `CBA_fnc_serverEvent`, so the server stays the single writer even though the
  event fires on a client.
- `getFlagTexture` already handles the faction-flag setting and the fallback to
  the configured texture path.
- The existing JIP `refreshFlags` request already re-broadcasts flags to joining
  clients.
- Antistasi re-runs `AIVEHinit` on vehicles restored from a save, so flags come
  back after a save/load without extra work.

## Accepted limitations

- **Manual reset is not remembered.** Resetting a flag by hand on an
  auto-flagged vehicle sticks until that vehicle is initialized again (save
  reload, respawn). There is no per-vehicle opt-out state.
- **Registration timing is fine.** Verified in-game on 2026-07-28 with Antistasi
  Ultimate 3020755032: `A3A_Events_fnc_addEventListener` is already defined when
  DETH's postInit runs, so the direct registration takes effect and a garage
  spawn reaches `handleVehicleInit`. The `CBA_fnc_waitUntilAndExecute` fallback
  was not needed.
- **A disabled `autoFlag` is indistinguishable from a broken listener in the
  logs.** `handleVehicleInit` returns at the `autoFlag` check before its first
  `TRACE`, so a forgotten setting looks exactly like a failed registration. The
  `TRACE_2` on the flagging path is the only positive signal; there is none for
  the disabled case.

## Out of scope

- Auto-applying the configured vehicle color (`vehicleColor`) to new vehicles.
  Only the flag is applied.
- Flagging static weapons, ammo boxes, or other non-vehicle objects that pass
  through `AIVEHinit`.
- Re-flagging vehicles that already exist when the setting is switched on.

## Verification

Manual, in-game — this is Arma script with no test harness in the repo:

1. With `autoFlag` off, spawn a vehicle from the garage. No flag appears.
2. Turn `autoFlag` on, spawn a vehicle from the garage. The configured flag
   appears, on the host and on a connected client.
3. With `useFactionFlag` on, a newly spawned vehicle carries the rebel faction's
   flag.
4. A vehicle spawned by an AI rebel garrison also carries the flag.
5. An enemy (non-`teamPlayer`) vehicle does not get a flag.
