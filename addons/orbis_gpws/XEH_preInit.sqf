#include "XEH_PREP.sqf"

// add addon settings
[
	"orbis_gpws_personallDefault",
	"LIST",
	["Default GPWS Mode", "Activates default GPWS when boarding planes with GPWS turned off"],
	"AWESome GPWS",
	[["none", "b747", "f16", "rita"], ["No default setting", "B747", "Betty (F-16)", "Rita"], 0]
] call CBA_Settings_fnc_init;

[
	"orbis_gpws_defaultVolumeLow",
	"LIST",
	["Default GPWS Volume", "Sets default GPWS volume (high/low)"],
	"AWESome GPWS",
	[[false, true], ["High", "Low"], 0]
] call CBA_Settings_fnc_init;

// add actions (ACE / vanilla) & events
if (orbis_awesome_hasACEInteractMenu) then {
	[] call orbis_gpws_fnc_addACEInteractMenu;
} else {
	player addEventHandler ["GetInMan", {_this call orbis_gpws_fnc_getInAddAction}];

	if !(vehicle player isEqualTo player) then {
		[player, "", vehicle player, []] call orbis_gpws_fnc_getInAddAction;
	};
};
