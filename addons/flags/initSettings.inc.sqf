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
    QGVAR(vehicleColor),
    "COLOR",
    [LLSTRING(vehicleColor_DisplayName), LLSTRING(vehicleColor_Description)],
    format ["DETH %1", LLSTRING(DisplayName)],
    [0, 0, 0, 0],
    2, // isGlobal
    {
        private _texture = _this call BIS_fnc_colorRGBAtoTexture;
        TRACE_2("Updating textures",_value,_texture);
        {
            _x setObjectTextureGlobal [0, _texture];
        } forEach GVAR(coloredVehicles);
    }
] call CBA_fnc_addSetting;

