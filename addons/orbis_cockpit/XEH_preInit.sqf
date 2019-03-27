#include "XEH_PREP.sqf"

// CBA based addon setting init
[
	"orbis_cockpit_shakeEnabled",
	"LIST",
	["Camera Shake", "Can enable or disable camera shake feature"],
	"AWESome Cockpit",
	[[true, false], ["Enabled", "Disabled"], 0]
] call CBA_Settings_fnc_init;

[
	"orbis_cockpit_groundMultiplier",
	"SLIDER",
	["Shake Multiplier (ground)", "Set multiplier for camera shake on ground"],
	"AWESome Cockpit",
	[0, 1, 1, 2]
] call CBA_Settings_fnc_init;

[
	"orbis_cockpit_speedMultiplier",
	"SLIDER",
	["Shake Multiplier (in-flight)", "Set multiplier for in-flight camera shake"],
	"AWESome Cockpit",
	[0, 1, 1, 2]
] call CBA_Settings_fnc_init;

// add actions (ACE / vanilla)
if (orbis_awesome_hasACEInteractMenu) then {
    [] call orbis_cockpit_fnc_addACEInteractMenu;
} else {
    player addEventHandler ["GetInMan", {_this call orbis_cockpit_fnc_getInAddAction}];

    if !(vehicle player isEqualTo player) then {
    	[player, "", vehicle player, []] call orbis_cockpit_fnc_getInAddAction;
    };
};
