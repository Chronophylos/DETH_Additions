#include "script_component.hpp"
/*
 * Author: Chronophylos
 * Reads the campaign identity from Antistasi's save state and shares it with clients,
 * so measurements from different sessions of the same campaign can be grouped.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * call DTA_statistics_fnc_initCampaign
 *
 * Public: No
 */

if (!isServer) exitWith {};

// A3A_saveTarget is [serverID, campaignID, map]; the campaign id survives save/load
GVAR(campaignId) = if (isNil "A3A_saveTarget") then { "" } else { A3A_saveTarget param [1, ""] };
publicVariable QGVAR(campaignId);

// The name the save was created with. Optional, so it may be empty.
GVAR(campaignName) = if (isNil "A3A_saveData") then { "" } else { A3A_saveData getOrDefault ["name", ""] };
publicVariable QGVAR(campaignName);

INFO_2("Campaign identified as %1 (%2)",GVAR(campaignId),GVAR(campaignName));
