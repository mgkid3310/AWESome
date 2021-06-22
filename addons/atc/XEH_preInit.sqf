#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

// CBA based addon setting init
[
	QGVAR(displayCallsign),
	"LIST",
	["Toggle ATC Radar display name", "Selects the pilot's name or callsign to be displayed on the ATC radar screen"],
	"AWESome ATC",
	[[0, 1, 2, 3], ["Personal Callsign", "Squad Callsign", "Vehicle Callsign", "Pilot Name"], 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(personalCallsign),
	"EDITBOX",
	["Set your personal callsign", "Sets your personal callsign displayed on ATC radar screen"],
	"AWESome ATC",
	"",
	2
] call CBA_Settings_fnc_init;

[
	QGVAR(unitSettingAlt),
	"LIST",
	["ATC Altitude unit", "Sets display unit for altitude on the ATC radar screen"],
	"AWESome ATC",
	[[false, true], ["meter (x10m)", "feet (x100ft)"], 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(unitSettingSpd),
	"LIST",
	["ATC Speed unit", "Sets display unit for speed on the ATC radar screen"],
	"AWESome ATC",
	[[false, true], ["kph (km/h)", "knot (kn)"], 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(radarUpdateInterval),
	"SLIDER",
	["ATC display Update Interval", "Sets ATC radar screen update interval, values below 0.50(s) may lower FPS"],
	"AWESome ATC",
	[0, 5, 0.5, 2]
] call CBA_Settings_fnc_init;

[
	QGVAR(radarTrailLength),
	"SLIDER",
	["ATC display trail length", "Sets trail length on ATC radar screen"],
	"AWESome ATC",
	[0, 10, 5, 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(displayProjectileTrails),
	"LIST",
	["Display missile trails", "Determines if missile trails will be drawn, displaying missile trails may lower FPS"],
	"AWESome ATC",
	[[true, false], ["Display", "Hide"], 1]
] call CBA_Settings_fnc_init;

[
	QGVAR(updateIntervalATIS),
	"LIST",
	["ATIS update interval", "Sets ATIS update interval with option for real-time data and manual update by ATC"],
	"AWESome ATC",
	[[5, 15, 30, 0, -1], ["5min", "15min", "30min", "Real-time data", "Manual Update (by ATC)"], 1]
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
