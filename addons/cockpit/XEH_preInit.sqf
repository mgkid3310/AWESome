#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

// CBA based addon setting init
[
	QGVAR(shakeEnabled),
	"LIST",
	[localize LSTRING(shakeEnabled_name), localize LSTRING(shakeEnabled_tooltip)],
	localize LSTRING(category),
	[[true, false], [localize LSTRING(shakeEnabled_true), localize LSTRING(shakeEnabled_false)], 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(groundMultiplier),
	"SLIDER",
	[localize LSTRING(groundMultiplier_name), localize LSTRING(groundMultiplier_tooltip)],
	localize LSTRING(category),
	[0, 1, 1, 2]
] call CBA_Settings_fnc_init;

[
	QGVAR(speedMultiplier),
	"SLIDER",
	[localize LSTRING(speedMultiplier_name), localize LSTRING(speedMultiplier_tooltip)],
	localize LSTRING(category),
	[0, 1, 1, 2]
] call CBA_Settings_fnc_init;

if !(EGVAR(main,hasACEUnits)) then {
	[
		QGVAR(checklistUnits),
		"LIST",
		[localize LSTRING(checklistUnits_name), localize LSTRING(checklistUnits_tooltip)],
		localize LSTRING(category),
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
