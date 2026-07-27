#include "script_component.hpp"
/*
 * Author: Chronophylos
 * Resolves the flag texture to apply. When the faction flag setting is enabled
 * the current Antistasi player faction's flag wins, otherwise the configured
 * texture path is used.
 *
 * Server only: Antistasi builds the faction hashmaps during its server init and
 * never broadcasts them, so clients cannot resolve the faction flag.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Flag texture <STRING>
 *
 * Example:
 * call DTA_flags_fnc_getFlagTexture
 */

private _texture = "";

if (GVAR(useFactionFlag)) then {
    // players are the rebels in Antistasi; the hashmap only exists once its
    // templates are loaded, so anything else falls through to the setting
    private _faction = missionNamespace getVariable ["A3A_faction_reb", createHashMap];

    if (_faction isEqualType createHashMap) then {
        _texture = _faction getOrDefault ["flagTexture", ""];
    };

    if !(_texture isEqualType "") then {
        _texture = "";
    };

    if (_texture isEqualTo "") then {
        TRACE_1("No faction flag available, falling back to the configured texture",GVAR(flagTexture));
    };
};

if (_texture isEqualTo "") then {
    _texture = GVAR(flagTexture);
};

_texture
