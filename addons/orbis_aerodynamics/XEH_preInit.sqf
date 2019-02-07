#include "XEH_PREP.sqf"

// CBA based addon setting init
private _enabled = profileNamespace getVariable ["orbis_aerodynamics_enabled", true];
missionNamespace setVariable ["orbis_aerodynamics_enabled", _enabled];
[
	"orbis_aerodynamics_enabled",
	"LIST",
	["Advanced Aerodynamics", "Can enable or disable Advanced Aerodynamics"],
	"AWESome Aerodynamics",
	[[true, false], ["Enabled", "Disabled"], [1, 0] select _enabled],
	nil,
	{
		missionNamespace setVariable ["orbis_aerodynamics_enabled", _this];
		profileNamespace setVariable ["orbis_aerodynamics_enabled", _this];
		saveProfileNamespace;
	}
] call CBA_Settings_fnc_init;

private _windMultiplier = profileNamespace getVariable ["orbis_aerodynamics_windMultiplier", 1];
missionNamespace setVariable ["orbis_aerodynamics_windMultiplier", _windMultiplier];
[
	"orbis_aerodynamics_windMultiplier",
	"SLIDER",
	["Wind Multiplier", "Sets shadow view distance"],
	"AWESome Aerodynamics",
	[0, 1, _windMultiplier, 2],
	nil,
	{
		missionNamespace setVariable ["orbis_aerodynamics_windMultiplier", _this];
		profileNamespace setVariable ["orbis_aerodynamics_windMultiplier", _this];
		saveProfileNamespace;
	}
] call CBA_Settings_fnc_init;

[
	"orbis_aerodynamics_loopFrameInterval",
	"SLIDER",
	["Loop Interval (Dev feature)", "Higher values have lower accuracy & low FPS drop"],
	"AWESome Aerodynamics",
	[1, 12, orbis_aerodynamics_loopFrameInterval, 0],
	nil,
	{
		orbis_aerodynamics_loopFrameInterval = _this;
	}
] call CBA_Settings_fnc_init;
