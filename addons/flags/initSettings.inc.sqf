[
    QGVAR(flagTexture), // setting
    "EDITBOX", // type
    [LLSTRING(flagTexture_DisplayName), LLSTRING(flagTexture_Description)], // display name and tooltip
    format ["DETH %1", LLSTRING(DisplayName)], // category
    "\A3\Data_F\Flags\flag_NATO_CO.paa", // default value
    2, // isGlobal
    {
        params ["_value"];
        {
            _x forceFlagTexture _value;
        } forEach GVAR(flaggedVehicles);
    }
] call CBA_fnc_addSetting;

[
    QGVAR(vehicleTexture),
    "EDITBOX",
    [LLSTRING(vehicleTexture_DisplayName), LLSTRING(vehicleTexture_Description)],
    format ["DETH %1", LLSTRING(DisplayName)],
    "#(rgb,8,8,3)color(1,1,1,1)",
    2 // isGlobal
] call CBA_fnc_addSetting;

