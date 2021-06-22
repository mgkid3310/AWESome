#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

// CBA based addon setting init
[
	QGVAR(shakeEnabled),
	"LIST",
	["Camera Shake", "Enable/disable camera shake feature"],
	"AWESome Cockpit",
	[[true, false], ["Enabled", "Disabled"], 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(groundMultiplier),
	"SLIDER",
	["Shake Multiplier (ground)", "Sets multiplier for camera shake on ground (incl. touchdown)"],
	"AWESome Cockpit",
	[0, 1, 1, 2]
] call CBA_Settings_fnc_init;

[
	QGVAR(speedMultiplier),
	"SLIDER",
	["Shake Multiplier (in-flight)", "Sets multiplier for in-flight camera shake"],
	"AWESome Cockpit",
	[0, 1, 1, 2]
] call CBA_Settings_fnc_init;

if !(EGVAR(main,hasACEUnits)) then {
	[
		QGVAR(checklistUnits),
		"LIST",
		["Checklist Units", "Selects speed unit used on checklists"],
		"AWESome Cockpit",
		[["KIAS", "kph"], ["KIAS", "km/h"], 0]
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
