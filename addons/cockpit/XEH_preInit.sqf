#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

// CBA based addon setting init
[
	QGVAR(shakeEnabled),
	"LIST",
	["Camera Shake", "Can enable or disable camera shake feature"],
	"AWESome Cockpit",
	[[true, false], ["Enabled", "Disabled"], 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(groundMultiplier),
	"SLIDER",
	["Shake Multiplier (ground)", "Set multiplier for camera shake on ground"],
	"AWESome Cockpit",
	[0, 1, 1, 2]
] call CBA_Settings_fnc_init;

[
	QGVAR(speedMultiplier),
	"SLIDER",
	["Shake Multiplier (in-flight)", "Set multiplier for in-flight camera shake"],
	"AWESome Cockpit",
	[0, 1, 1, 2]
] call CBA_Settings_fnc_init;

if !(EGVAR(main,hasACEUnits)) then {
	[
		QGVAR(checklistUnits),
		"LIST",
		["Checklist Units", "Units to use for speeds on checklists"],
		"AWESome Cockpit",
		[["KIAS", "KM/H"],["KIAS", "KM/H"],0],
	] call CBA_Settings_fnc_init;
};

// add actions (ACE / vanilla)
if (EGVAR(main,hasACEInteractMenu)) then {
	[] call FUNC(addACEInteractMenu);
} else {
	player addEventHandler ["GetInMan", {_this call FUNC(getInAddAction)}];

	if !(vehicle player isEqualTo player) then {
		[player, "", vehicle player, []] call FUNC(getInAddAction);
	};
};
