#include "XEH_PREP.sqf"

// CBA based addon setting init
private _callsign = profileNamespace getVariable ["orbis_atc_displayCallsign", false];
missionNamespace setVariable ["orbis_atc_displayCallsign", _callsign];
[
	"orbis_atc_transponderName",
	"LIST",
	["Toggle ATC Radar display name", "Toggles between the pilot's name and callsign displayed ATC Radar screen"],
	"AWESome ATC",
	[[false, true], ["Name", "Callsign"], 0],
	nil,
	{
		missionNamespace setVariable ["orbis_atc_displayCallsign", _this];
		profileNamespace setVariable ["orbis_atc_displayCallsign", _this];
		saveProfileNamespace;
	}
] call CBA_Settings_fnc_init;

private _unitSetting = profileNamespace getVariable ["orbis_atc_unitSetting", 0];
missionNamespace setVariable ["orbis_atc_unitSetting", _unitSetting];
[
	"orbis_atc_unitSetting",
	"LIST",
	["ATC display unit", "Set display units for altitude and speed"],
	"AWESome ATC",
	[[0, 1, 2, 3], ["meter / kph", "meter / knot", "feet / kph", "feet / knot"], 0],
	nil,
	{
		missionNamespace setVariable ["orbis_atc_unitSetting", _this];
		profileNamespace setVariable ["orbis_atc_unitSetting", _this];
		saveProfileNamespace;
	}
] call CBA_Settings_fnc_init;

private _realtime = profileNamespace getVariable ["orbis_atc_updateATISself", true];
missionNamespace setVariable ["orbis_atc_updateATISself", _realtime];
[
	"orbis_atc_updateATISself",
	"CHECKBOX",
	["Real-time ATIS data update", "Update ATIS data everytime when ATIS is played"],
	"AWESome ATC",
	true,
	nil,
	{
		missionNamespace setVariable ["orbis_atc_updateATISself", _this];
		profileNamespace setVariable ["orbis_atc_updateATISself", _this];
		saveProfileNamespace;
	}
] call CBA_Settings_fnc_init;
