[
    QGVAR(autoFlag), // setting
    "CHECKBOX", // type
    [LLSTRING(autoFlag_DisplayName), LLSTRING(autoFlag_Description)], // display name and tooltip
    format ["DETH %1", LLSTRING(DisplayName)], // category
    false, // default value
    2 // isGlobal
    // no change callback, this only affects vehicles spawned from now on
] call CBA_fnc_addSetting;

[
    QGVAR(useFactionFlag), // setting
    "CHECKBOX", // type
    [LLSTRING(useFactionFlag_DisplayName), LLSTRING(useFactionFlag_Description)], // display name and tooltip
    format ["DETH %1", LLSTRING(DisplayName)], // category
    false, // default value
    2, // isGlobal
    {
        // runs on every machine, but only the server touches the vehicles
        call FUNC(refreshFlags);
    }
] call CBA_fnc_addSetting;

[
    QGVAR(flagTexture), // setting
    "EDITBOX", // type
    [LLSTRING(flagTexture_DisplayName), LLSTRING(flagTexture_Description)], // display name and tooltip
    format ["DETH %1", LLSTRING(DisplayName)], // category
    "\A3\Data_F\Flags\flag_NATO_CO.paa", // default value
    2, // isGlobal
    {
        // runs on every machine, but only the server touches the vehicles
        call FUNC(refreshFlags);
    }
] call CBA_fnc_addSetting;

[
    QGVAR(vehicleColor),
    "COLOR",
    [LLSTRING(vehicleColor_DisplayName), LLSTRING(vehicleColor_Description)],
    format ["DETH %1", LLSTRING(DisplayName)],
    [0, 0, 0, 0],
    2, // isGlobal
    {
        // runs on every machine, but only the server touches the vehicles
        call FUNC(refreshTextures);
    }
] call CBA_fnc_addSetting;

