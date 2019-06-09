#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

// CBA based addon setting init
[
	QGVAR(enabled),
	"LIST",
	["Advanced Aerodynamics", "Can enable or disable Advanced Aerodynamics"],
	"AWESome Aerodynamics",
	[[true, false], ["Enabled", "Disabled"], 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(windMultiplier),
	"SLIDER",
	["Wind Multiplier", "Set wind effect multiplier"],
	"AWESome Aerodynamics",
	[0, 1, 1, 2]
] call CBA_Settings_fnc_init;
