#include "XEH_PREP.sqf"

// CBA based addon setting init
[
	"orbis_aerodynamics_enabled",
	"LIST",
	["Advanced Aerodynamics", "Can enable or disable Advanced Aerodynamics"],
	"AWESome Aerodynamics",
	[[true, false], ["Enabled", "Disabled"], 0]
] call CBA_Settings_fnc_init;

[
	"orbis_aerodynamics_windMultiplier",
	"SLIDER",
	["Wind Multiplier", "Set wind effect multiplier"],
	"AWESome Aerodynamics",
	[0, 1, 1, 2]
] call CBA_Settings_fnc_init;

[
	"orbis_aerodynamics_loopFrameInterval",
	"SLIDER",
	["Loop Interval (Dev feature)", "Higher values have lower accuracy & low FPS drop"],
	"AWESome Aerodynamics",
	[0, 12, 0, 0]
] call CBA_Settings_fnc_init;
