#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.sqf"
ADDON = true;

[
	"awesome_gpws_personallDefault",
	"LIST",
	["Default GPWS Mode", "Activates default GPWS when boarding planes with GPWS turned off"],
	"AWESome GPWS",
	[["none", "b747", "f16", "rita"], ["No default setting", "B747", "Betty (F-16)", "Rita"], 0]
] call CBA_Settings_fnc_init;

[
	"awesome_gpws_defaultVolumeLow",
	"LIST",
	["Default GPWS Volume", "Sets default GPWS volume (high/low)"],
	"AWESome GPWS",
	[[false, true], ["High", "Low"], 0]
] call CBA_Settings_fnc_init;
