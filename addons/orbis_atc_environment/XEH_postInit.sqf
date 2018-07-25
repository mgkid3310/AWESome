player setVariable ["hasOrbisATC", true, true];

orbis_atc_scaleStd = 0.0015;
if (isNumber (configFile >> "CfgWorlds" >> worldName >> "mapSize")) then {
    orbis_atc_scaleStd = (orbis_atc_scaleStd * 30720) / getNumber (configFile >> "CfgWorlds" >> worldName >> "mapSize");
};
orbis_atc_fontMax = 0.1;
orbis_atc_fontMin = 0.05;
orbis_atc_spaceMax = 1.5;
orbis_atc_spaceMin = 0.75;

// CBA based addon setting init
private _callsign = profileNamespace getVariable ["orbis_atc_displayCallsign", false];
private _unitSetting = profileNamespace getVariable ["orbis_atc_unitSetting", 0];
private _realtime = profileNamespace getVariable ["orbis_atc_updateATISself", true];
missionNamespace setVariable ["orbis_atc_displayCallsign", _callsign];
missionNamespace setVariable ["orbis_atc_unitSetting", _unitSetting];
missionNamespace setVariable ["orbis_atc_updateATISself", _realtime];

[
	"orbis_atc_transponderName",
	"LIST",
	["Toggle ATC Radar display name", "Toggles between the pilot's name and callsign displayed ATC Radar screen"],
	"AWESome ATC",
	[[false, true], ["Name", "Callsign"], [0, 1] select _callsign],
	nil,
	{
		missionNamespace setVariable ["orbis_atc_displayCallsign", _this];
		profileNamespace setVariable ["orbis_atc_displayCallsign", _this];
	}
] call CBA_Settings_fnc_init;

[
	"orbis_atc_unitSetting",
	"LIST",
	["ATC display unit", "Set display units for altitude and speed"],
	"AWESome ATC",
	[[0, 1, 2, 3], ["meter / kph", "meter / knot", "feet / kph", "feet / knot"], _unitSetting],
	nil,
	{
		missionNamespace setVariable ["orbis_atc_displayCallsign", _this];
		profileNamespace setVariable ["orbis_atc_displayCallsign", _this];
	}
] call CBA_Settings_fnc_init;

[
	"orbis_atc_updateATISself",
	"CHECKBOX",
	["Real-time ATIS data update", "Update ATIS data everytime when ATIS is played"],
	"AWESome ATC",
	_realtime,
	nil,
	{
		missionNamespace setVariable ["orbis_atc_updateATISself", _this];
		profileNamespace setVariable ["orbis_atc_updateATISself", _this];
	}
] call CBA_Settings_fnc_init;

// add actions (ACE / vanilla)
if (orbis_awesome_hasACEInteractMenu) then {
    [] call orbis_atc_fnc_addACEInteractMenu;
} else {
    if !(vehicle player isEqualTo player) then {
    	[player, "", vehicle player, []] call orbis_atc_fnc_getInAddAction;
    };
    player addEventHandler ["GetInMan", {_this call orbis_atc_fnc_getInAddAction}];
};

// run initial ATIS data update
[] spawn {
    sleep 10;
    [] call orbis_atc_fnc_updateATISdata;
};

// run periodic check
[] spawn orbis_atc_fnc_periodicCheck;
