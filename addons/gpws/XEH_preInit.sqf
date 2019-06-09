#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

// add addon settings
[
	QGVAR(personalDefault),
	"LIST",
	["Default GPWS Mode", "Activates default GPWS when boarding planes with GPWS turned off"],
	"AWESome GPWS",
	[["none", "b747", "f16", "rita"], ["No default setting", "B747", "Betty (F-16)", "Rita"], 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(defaultVolumeLow),
	"LIST",
	["Default GPWS Volume", "Sets default GPWS volume (high/low)"],
	"AWESome GPWS",
	[[false, true], ["High", "Low"], 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(automaticTransponder),
	"CHECKBOX",
	["Use Automatic Transponder", "Transponder mode is change automatically"],
	"AWESome GPWS",
	true
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
