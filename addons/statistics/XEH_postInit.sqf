#include "script_component.hpp"

// Session id is created on the server/host and shared so clients can stamp payloads
if (isServer) then {
    GVAR(sessionId) = hashValue systemTime;
    publicVariable QGVAR(sessionId);
};

// Client-local ACE events → build payload → CBA_fnc_serverEvent (DB bridge on server/host)
if (hasInterface) then {
    ["ace_firedPlayer", LINKFUNC(fired)] call CBA_fnc_addEventHandler;
    ["ace_firedPlayerVehicle", LINKFUNC(firedVehicle)] call CBA_fnc_addEventHandler;
    ["ace_treatmentSucceded", LINKFUNC(treated)] call CBA_fnc_addEventHandler;
    ["ace_finger_fingered", LINKFUNC(fingered)] call CBA_fnc_addEventHandler;
};

// Check for Antistasi compatibility
private _isAntistasiLoaded = isClass (configFile >> "CfgPatches" >> "A3A_ultimate");
if (_isAntistasiLoaded) then {
    INFO("Antistasi detected");
    [{!isNil "A3A_startupState" && {A3A_startupState isEqualTo "completed"}}, {
        LOG("Antistasi startup complete, adding per frame handlers");
        if (isServer) then {
            [LINKFUNC(antistasiServer), 10, []] call CBA_fnc_addPerFrameHandler;
        };
        if (hasInterface) then {
            [LINKFUNC(antistasiPlayer), 10, []] call CBA_fnc_addPerFrameHandler;
        };
    }] call CBA_fnc_waitUntilAndExecute;
};

// Server/host-only collectors (mission EHs + periodic metrics)
if (!isServer) exitWith {};

[LINKFUNC(score), 10, []] call CBA_fnc_addPerFrameHandler;
call FUNC(cps);

["ace_unconscious", LINKFUNC(unconscious)] call CBA_fnc_addEventHandler;

addMissionEventHandler ["PlayerConnected", LINKFUNC(connected)];
addMissionEventHandler ["PlayerDisconnected", LINKFUNC(disconnected)];
addMissionEventHandler ["HandleChatMessage", LINKFUNC(chat)];

[LINKFUNC(session), 10, []] call CBA_fnc_addPerFrameHandler;
