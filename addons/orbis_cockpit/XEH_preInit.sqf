#include "XEH_PREP.sqf"

// CBA based addon setting init
private _enabled = profileNamespace getVariable ["orbis_cockpit_shakeEnabled", true];
missionNamespace setVariable ["orbis_cockpit_shakeEnabled", _enabled];
[
	"orbis_cockpit_shakeEnabled",
	"LIST",
	["Camera Shake", "Can enable or disable camera shake feature"],
	"AWESome Cockpit",
	[[true, false], ["Enabled", "Disabled"], 0],
	nil,
	{
		missionNamespace setVariable ["orbis_cockpit_shakeEnabled", _this];
		profileNamespace setVariable ["orbis_cockpit_shakeEnabled", _this];
		saveProfileNamespace;
	}
] call CBA_Settings_fnc_init;

private _groundMultiplier = profileNamespace getVariable ["orbis_cockpit_groundMultiplier", 1];
missionNamespace setVariable ["orbis_cockpit_groundMultiplier", _groundMultiplier];
[
	"orbis_cockpit_groundMultiplier",
	"SLIDER",
	["Shake Multiplier (ground)", "Set multiplier for camera shake on ground"],
	"AWESome Cockpit",
	[0, 1, 1, 2],
	nil,
	{
		missionNamespace setVariable ["orbis_cockpit_groundMultiplier", _this];
		profileNamespace setVariable ["orbis_cockpit_groundMultiplier", _this];
		saveProfileNamespace;
	}
] call CBA_Settings_fnc_init;

private _speedMultiplier = profileNamespace getVariable ["orbis_cockpit_speedMultiplier", 1];
missionNamespace setVariable ["orbis_cockpit_speedMultiplier", _speedMultiplier];
[
	"orbis_cockpit_speedMultiplier",
	"SLIDER",
	["Shake Multiplier (in-flight)", "Set multiplier for in-flight camera shake"],
	"AWESome Cockpit",
	[0, 1, 1, 2],
	nil,
	{
		missionNamespace setVariable ["orbis_cockpit_speedMultiplier", _this];
		profileNamespace setVariable ["orbis_cockpit_speedMultiplier", _this];
		saveProfileNamespace;
	}
] call CBA_Settings_fnc_init;
