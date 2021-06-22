#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

// add addon settings
[
	QGVAR(personalDefault),
	"LIST",
	[localize LSTRING(personalDefault_name), localize LSTRING(personalDefault_tooltip)],
	localize LSTRING(category),
	[["none", "b747", "f16", "rita"], [localize LSTRING(personalDefault_none), "B747", "Betty (F-16)", "Rita"], 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(defaultVolume),
	"LIST",
	[localize LSTRING(defaultVolume_name), localize LSTRING(defaultVolume_tooltip)],
	localize LSTRING(category),
	[[false, true], [localize LSTRING(defaultVolume_high), localize LSTRING(defaultVolume_low)], 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(automaticTransponder),
	"LIST",
	[localize LSTRING(automaticTransponder_name), localize LSTRING(automaticTransponder_tooltip)],
	localize LSTRING(category),
	[[true, false], [localize LSTRING(automaticTransponder_automatic), localize LSTRING(automaticTransponder_manual)], 0]
] call CBA_Settings_fnc_init;

// add actions (ACE / vanilla) & events
if (EGVAR(main,hasACEInteractMenu)) then {
	[] call FUNC(addACEInteractMenu);
} else {
	player addEventHandler ["GetInMan", {_this call FUNC(getInAddAction)}];

	if !(vehicle player isEqualTo player) then {
		[player, "", vehicle player, []] call FUNC(getInAddAction);
	};
};
