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
	QGVAR(dynamicWindMode),
	"LIST",
	["Dynamic Winds", "Enable/Disable dynamic wind effects, e.g., gust, wake turbulence and more."],
	"AWESome Aerodynamics",
	[[2, 1, 0], ["Dynamic", "Simple", "Static"], 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(windMultiplier),
	"SLIDER",
	["Wind Multiplier", "Sets how strong the wind effect will be"],
	"AWESome Aerodynamics",
	[0, 1, 1, 2]
] call CBA_Settings_fnc_init;

[
	QGVAR(pylonMassMultiplierGlobal),
	"SLIDER",
	["Pylon Mass Multiplier", "Sets the multiplier for pylon weapon's mass"],
	"AWESome Aerodynamics",
	[0, 1, 1, 2]
] call CBA_Settings_fnc_init;

[
	QGVAR(pylonDragMultiplierGlobal),
	"SLIDER",
	["Pylon Drag Multiplier", "Sets the multiplier for pylon weapon's drag"],
	"AWESome Aerodynamics",
	[0, 1, 1, 2]
] call CBA_Settings_fnc_init;
