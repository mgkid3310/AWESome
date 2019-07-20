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
	[[0, 1, 2], ["Name", "Callsign", "Custom Callsign"], 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(unitSettingAlt),
	"LIST",
	["ATC Altitude unit", "Sets display unit for altitude on the ATC radar screen"],
	"AWESome ATC",
	[[false, true], ["meter (10m)", "feet (100ft)"], 0]
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
	"CHECKBOX",
	["Display missile trails", "Enable/disable drawing missile trails"],
	"AWESome ATC",
	false
] call CBA_Settings_fnc_init;

[
	QGVAR(realtimeATIS),
	"CHECKBOX",
	["Real-time ATIS data update", "Use real-time data whenever the ATIS is played"],
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
