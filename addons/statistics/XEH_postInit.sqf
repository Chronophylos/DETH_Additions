#include "script_component.hpp"

private _isAntistasiLoaded = isClass (configFile >> "CfgPatches" >> "A3A_ultimate");
if (_isAntistasiLoaded) then {
    INFO("Antistasi detected");
    [{!isNil "A3A_startupState" && A3A_startupState isEqualTo "completed"}, {
        LOG("Antistasi startup complete, adding per frame handler");
        [LINKFUNC(antistasiServer), 10, []] call CBA_fnc_addPerFrameHandler;
        [LINKFUNC(antistasiPlayer), 10, []] call CBA_fnc_addPerFrameHandler;
    }] call CBA_fnc_waitUntilAndExecute;
};

// Score evaluation
[LINKFUNC(score), 10, []] call CBA_fnc_addPerFrameHandler;

// Start CPS evaluation
call FUNC(cps);

// Start fired evaluation
["ace_firedPlayer", LINKFUNC(fired)] call CBA_fnc_addEventHandler;
["ace_firedPlayerVehicle", LINKFUNC(firedVehicle)] call CBA_fnc_addEventHandler;

// Start unconscious evaluation
["ace_unconscious", LINKFUNC(unconscious)] call CBA_fnc_addEventHandler;

// Start player connection evaluation
addMissionEventHandler ["PlayerConnected", LINKFUNC(connected)];
addMissionEventHandler ["PlayerDisconnected", LINKFUNC(disconnected)];

// Start chat evaluation
addMissionEventHandler ["HandleChatMessage", LINKFUNC(chat)];

// Start session evaluation
[LINKFUNC(session), 1, []] call CBA_fnc_addPerFrameHandler;
