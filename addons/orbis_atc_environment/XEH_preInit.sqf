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
	"orbis_atc_unitSetting",
	"LIST",
	["ATC display unit", "Set display units for altitude and speed"],
	"AWESome ATC",
	[[0, 1, 2, 3], ["meter / kph", "meter / knot", "feet / kph", "feet / knot"], 0]
] call CBA_Settings_fnc_init;

[
	"orbis_atc_realtimeATIS",
	"CHECKBOX",
	["Real-time ATIS data update", "Update ATIS data everytime when ATIS is played"],
	"AWESome ATC",
	true
] call CBA_Settings_fnc_init;
