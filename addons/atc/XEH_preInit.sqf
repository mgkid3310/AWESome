#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

// CBA based addon setting init
[
	QGVAR(displayCallsign),
	"LIST",
	["Toggle ATC Radar display name", "Toggles between the pilot's name and callsign displayed ATC Radar screen"],
	"AWESome ATC",
	[[0, 1, 2], ["Name", "Callsign", "Custom Callsign"], 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(unitSettingAlt),
	"LIST",
	["ATC Altitude unit", "Set display unit for altitude"],
	"AWESome ATC",
	[[false, true], ["meter (10m)", "feet (100ft)"], 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(unitSettingSpd),
	"LIST",
	["ATC Speed unit", "Set display unit for speed"],
	"AWESome ATC",
	[[false, true], ["kph (km/h)", "knot (kn)"], 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(radarUpdateInterval),
	"SLIDER",
	["ATC display Update Interval", "Set display update interval"],
	"AWESome ATC",
	[0, 5, 1, 1]
] call CBA_Settings_fnc_init;

[
	QGVAR(radarTrailLength),
	"SLIDER",
	["ATC display trail length", "Set display trail length"],
	"AWESome ATC",
	[0, 10, 5, 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(realtimeATIS),
	"CHECKBOX",
	["Real-time ATIS data update", "Update ATIS data everytime when ATIS is played"],
	"AWESome ATC",
	true
] call CBA_Settings_fnc_init;

// add actions (ACE / vanilla)
if (EGVAR(main,hasACEInteractMenu)) then {
	[] call FUNC(addACEInteractMenu);
} else {
	player addEventHandler ["GetInMan", {_this call FUNC(getInAddAction)}];

	if !(vehicle player isEqualTo player) then {
		[player, "", vehicle player, []] call FUNC(getInAddAction);
	};
};
