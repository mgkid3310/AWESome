#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.sqf"
ADDON = true;

[
	"awesome_aerodynamics_enabled",
	"LIST",
	["Advanced Aerodynamics", "Can enable or disable Advanced Aerodynamics"],
	"AWESome Aerodynamics",
	[[true, false], ["Enabled", "Disabled"], 1]
] call CBA_Settings_fnc_init;

[
	"awesome_aerodynamics_windMultiplier",
	"SLIDER",
	["Wind Multiplier", "Sets shadow view distance"],
	"AWESome Aerodynamics",
	[0, 1, _windMultiplier, 2]
] call CBA_Settings_fnc_init;

[
	"awesome_aerodynamics_loopFrameInterval",
	"SLIDER",
	["Loop Interval (Dev feature)", "Higher values have lower accuracy & low FPS drop"],
	"AWESome Aerodynamics",
	[1, 12, awesome_aerodynamics_loopFrameInterval, 1]
] call CBA_Settings_fnc_init;
