#include "script_component.hpp"
/*
 * Author: Chronophylos
 * Builds the tag set shared by every statistics measurement: the session it was
 * recorded in and, when Antistasi is running, the campaign it belongs to.
 *
 * Arguments:
 * None
 *
 * Return Value:
 * Tags <ARRAY> of [key, value] pairs
 *
 * Example:
 * call DTA_statistics_fnc_commonTags
 *
 * Public: No
 */

private _tags = [
    ["session_id", GVAR(sessionId)]
];

// Campaign info is only known once Antistasi has started up. Blank values are left
// out entirely instead of being written as empty tags.
private _campaignId = GETGVAR(campaignId,"");
if (_campaignId isNotEqualTo "") then { _tags pushBack ["campaign_id", _campaignId] };

private _campaignName = GETGVAR(campaignName,"");
if (_campaignName isNotEqualTo "") then { _tags pushBack ["campaign_name", _campaignName] };

_tags
