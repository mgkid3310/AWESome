#include "XEH_PREP.sqf"

// CBA based addon setting init
[
	"orbis_atc_displayCallsign",
	"LIST",
	["Toggle ATC Radar display name", "Toggles between the pilot's name and callsign displayed ATC Radar screen"],
	"AWESome ATC",
	[[false, true], ["Name", "Callsign"], 0]
] call CBA_Settings_fnc_init;

[
	"orbis_atc_unitSettingAlt",
	"LIST",
	["ATC Altitude unit", "Set display unit for altitude"],
	"AWESome ATC",
	[[false, true], ["meter (10m)", "feet (100ft)"], 0]
] call CBA_Settings_fnc_init;

[
	"orbis_atc_unitSettingSpd",
	"LIST",
	["ATC Speed unit", "Set display unit for speed"],
	"AWESome ATC",
	[[false, true], ["kph (km/h)", "knot (kn)"], 0]
] call CBA_Settings_fnc_init;

[
	"orbis_atc_radarUpdateInterval",
	"SLIDER",
	["ATC display Update Interval", "Set display update interval"],
	"AWESome ATC",
	[0, 5, 1, 1]
] call CBA_Settings_fnc_init;

[
	"orbis_atc_radarTrailLength",
	"SLIDER",
	["ATC display trail length", "Set display trail length"],
	"AWESome ATC",
	[0, 10, 5, 0]
] call CBA_Settings_fnc_init;

[
	"orbis_atc_realtimeATIS",
	"CHECKBOX",
	["Real-time ATIS data update", "Update ATIS data everytime when ATIS is played"],
	"AWESome ATC",
	true
] call CBA_Settings_fnc_init;

// add actions (ACE / vanilla)
if (orbis_awesome_hasACEInteractMenu) then {
	[] call orbis_atc_fnc_addACEInteractMenu;
} else {
	player addEventHandler ["GetInMan", {_this call orbis_atc_fnc_getInAddAction}];

	if !(vehicle player isEqualTo player) then {
		[player, "", vehicle player, []] call orbis_atc_fnc_getInAddAction;
	};
};
