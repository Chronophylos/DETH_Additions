#include "script_component.hpp"

private _isAntistasiLoaded = isClass (configFile >> "CfgPatches" >> "A3A_ultimate");
if (_isAntistasiLoaded) then {
    INFO("Antistasi detected");
    [{!isNil "A3A_startupState" && A3A_startupState isEqualTo "completed"}, {
        LOG("Antistasi startup complete, adding per frame handler");
        if (isServer) then {
            [LINKFUNC(antistasiServer), 10, []] call CBA_fnc_addPerFrameHandler;
        } else {
            [LINKFUNC(antistasiPlayer), 10, []] call CBA_fnc_addPerFrameHandler;
        };
    }] call CBA_fnc_waitUntilAndExecute;
};


["ace_firedPlayer", LINKFUNC(fired)] call CBA_fnc_addEventHandler;
["ace_firedPlayerVehicle", LINKFUNC(firedVehicle)] call CBA_fnc_addEventHandler;

["ace_treatmentSucceded", LINKFUNC(treated)] call CBA_fnc_addEventHandler;

// Add ace_finger_fingered event handler to record finger pointing measurements
["ace_finger_fingered", LINKFUNC(fingered)] call CBA_fnc_addEventHandler;

if (isServer) then {
    [LINKFUNC(score), 10, []] call CBA_fnc_addPerFrameHandler;

    call FUNC(cps);

    ["ace_unconscious", LINKFUNC(unconscious)] call CBA_fnc_addEventHandler;

    addMissionEventHandler ["PlayerConnected", LINKFUNC(connected)];
    addMissionEventHandler ["PlayerDisconnected", LINKFUNC(disconnected)];

    addMissionEventHandler ["HandleChatMessage", LINKFUNC(chat)];

    [LINKFUNC(session), 10, []] call CBA_fnc_addPerFrameHandler;
};
