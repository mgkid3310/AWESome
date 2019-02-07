#include "XEH_PREP.sqf"

[
	"orbis_aerodynamics_enabled",
	"LIST",
	["Advanced Aerodynamics", "Can enable or disable Advanced Aerodynamics"],
	"AWESome Aerodynamics",
	[[true, false], ["Enabled", "Disabled"], 1],
	nil,
] call CBA_Settings_fnc_init;

[
	"orbis_aerodynamics_windMultiplier",
	"SLIDER",
	["Wind Multiplier", "Sets shadow view distance"],
	"AWESome Aerodynamics",
	[0, 1, _windMultiplier, 2],
] call CBA_Settings_fnc_init;

[
	"orbis_aerodynamics_loopFrameInterval",
	"SLIDER",
	["Loop Interval (Dev feature)", "Higher values have lower accuracy & low FPS drop"],
	"AWESome Aerodynamics",
	[1, 12, orbis_aerodynamics_loopFrameInterval, 1],
] call CBA_Settings_fnc_init;
