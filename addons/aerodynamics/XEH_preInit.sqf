#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

// CBA based addon setting init
[
	QGVAR(enabled),
	"LIST",
	[localize LSTRING(enabled_name), localize LSTRING(enabled_tooltip)],
	localize LSTRING(category),
	[[true, false], [localize LSTRING(enabled_true), localize LSTRING(enabled_false)], 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(dynamicWindMode),
	"LIST",
	[localize LSTRING(dynamicWindMode_name), localize LSTRING(dynamicWindMode_tooltip)],
	localize LSTRING(category),
	[[2, 1, 0], [localize LSTRING(dynamic), localize LSTRING(simple), localize LSTRING(static)], 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(windMultiplier),
	"SLIDER",
	[localize LSTRING(windMultiplier_name), localize LSTRING(windMultiplier_tooltip)],
	localize LSTRING(category),
	[0, 1, 1, 2]
] call CBA_Settings_fnc_init;

[
	QGVAR(pylonMassMultiplierGlobal),
	"SLIDER",
	[localize LSTRING(pylonMassMultiplierGlobal_name), localize LSTRING(pylonMassMultiplierGlobal_tooltip)],
	localize LSTRING(category),
	[0, 1, 1, 2]
] call CBA_Settings_fnc_init;

[
	QGVAR(pylonDragMultiplierGlobal),
	"SLIDER",
	[localize LSTRING(pylonDragMultiplierGlobal_name), localize LSTRING(pylonDragMultiplierGlobal_tooltip)],
	localize LSTRING(category),
	[0, 1, 1, 2]
] call CBA_Settings_fnc_init;
