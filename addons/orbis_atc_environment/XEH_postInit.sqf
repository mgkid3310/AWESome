orbis_atc_scaleStd = 0.0015;
if (isNumber (configFile >> "CfgWorlds" >> worldName >> "mapSize")) then {
    orbis_atc_scaleStd = (orbis_atc_scaleStd * 30720) / getNumber (configFile >> "CfgWorlds" >> worldName >> "mapSize");
};
orbis_atc_fontMin = 0.05;
orbis_atc_fontMax = 0.1;
orbis_atc_lineSpacing = 0.9;

// CBA based addon setting init
if (hasInterface) then {
	private _enabled = profileNamespace getVariable ["orbis_atc_updateATISself", true];
	missionNamespace setVariable ["orbis_atc_updateATISself", _required];

	[
		"orbis_atc_updateATISself",
		"CHECKBOX",
		["Real-time ATIS data update", "Update ATIS data everytime when ATIS is played"],
		"AWESome",
		_enabled,
		nil,
		{
			missionNamespace setVariable ["orbis_atc_updateATISself", _this];
			profileNamespace setVariable ["orbis_atc_updateATISself", _this];
		}
	] call CBA_Settings_fnc_init;
};

[] spawn {
    sleep 10;
    [] call orbis_atc_fnc_updateATISdata;
};
