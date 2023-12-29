#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.sqf"
ADDON = true;

// CBA based addon setting init
[
	QGVAR(displayCallsign),
	"LIST",
	[localize LSTRING(displayCallsign_name), localize LSTRING(displayCallsign_tooltip)],
	[localize LSTRING(category), localize LSTRING(radar)],
	[[0, 1, 2, 3], [localize LSTRING(personal), localize LSTRING(squad), localize LSTRING(aircraft), localize LSTRING(pilot)], 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(personalCallsign),
	"EDITBOX",
	[localize LSTRING(personalCallsign_name), localize LSTRING(personalCallsign_tooltip)],
	[localize LSTRING(category), localize LSTRING(radar)],
	"",
	2
] call CBA_Settings_fnc_init;

[
	QGVAR(unitSettingAlt),
	"LIST",
	[localize LSTRING(unitSettingAlt_name), localize LSTRING(unitSettingAlt_tooltip)],
	[localize LSTRING(category), localize LSTRING(radar)],
	[[false, true], [localize LSTRING(unitSettingAlt_meter), localize LSTRING(unitSettingAlt_feet)], 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(unitSettingSpd),
	"LIST",
	[localize LSTRING(unitSettingSpd_name), localize LSTRING(unitSettingSpd_tooltip)],
	[localize LSTRING(category), localize LSTRING(radar)],
	[[false, true], [localize LSTRING(unitSettingSpd_kph), localize LSTRING(unitSettingSpd_knot)], 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(radarUpdateInterval),
	"SLIDER",
	[localize LSTRING(radarUpdateInterval_name), localize LSTRING(radarUpdateInterval_tooltip)],
	[localize LSTRING(category), localize LSTRING(radar)],
	[0, 5, 0.5, 2]
] call CBA_Settings_fnc_init;

[
	QGVAR(radarTrailLength),
	"SLIDER",
	[localize LSTRING(radarTrailLength_name), localize LSTRING(radarTrailLength_tooltip)],
	[localize LSTRING(category), localize LSTRING(radar)],
	[0, 10, 5, 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(displayProjectileTrails),
	"LIST",
	[localize LSTRING(displayProjectileTrails_name), localize LSTRING(displayProjectileTrails_tooltip)],
	[localize LSTRING(category), localize LSTRING(radar)],
	[[true, false], [localize LSTRING(display), localize LSTRING(hide)], 1]
] call CBA_Settings_fnc_init;

[
	QGVAR(updateIntervalATIS),
	"LIST",
	[localize LSTRING(updateIntervalATIS_name), localize LSTRING(updateIntervalATIS_tooltip)],
	[localize LSTRING(category), localize LSTRING(atis)],
	[[5, 15, 30, 0, -1], ["5min", "15min", "30min", localize LSTRING(realTime), localize LSTRING(manual)], 1]
] call CBA_Settings_fnc_init;

[
	QGVAR(displayTextATIS),
	"LIST",
	[localize LSTRING(displayTextATIS_name), localize LSTRING(displayTextATIS_tooltip)],
	[localize LSTRING(category), localize LSTRING(atis)],
	[[0, 1, 2], ["None", "hint", "systemChat"], 1]
] call CBA_Settings_fnc_init;

[
	QGVAR(unitSettingLatGCI),
	"LIST",
	[localize LSTRING(unitSettingLatGCI_name), localize LSTRING(unitSettingLatGCI_tooltip)],
	[localize LSTRING(category), localize LSTRING(gci)],
	[[false, true], [localize LSTRING(unitSettingGCI_km), localize LSTRING(unitSettingGCI_NM)], 0]
] call CBA_Settings_fnc_init;

[
	QGVAR(unitSettingHozGCI),
	"LIST",
	[localize LSTRING(unitSettingHozGCI_name), localize LSTRING(unitSettingHozGCI_tooltip)],
	[localize LSTRING(category), localize LSTRING(gci)],
	[[false, true], [localize LSTRING(unitSettingGCI_m), localize LSTRING(unitSettingGCI_ft)], 0]
] call CBA_Settings_fnc_init;

// CBA based keybind init
[
	localize LSTRING(category),
	localize LSTRING(gci),
	[localize LSTRING(classifyAsHostile_name), localize LSTRING(classifyAsHostile_tooltip)],
	{
	    missionNameSpace setVariable [QGVAR(classifyAsHostile), true];
	}, {
	    missionNameSpace setVariable [QGVAR(classifyAsHostile), false];
	},
	[0, [false, false, false]]
] call CBA_fnc_addKeybind;

// add actions (ACE / vanilla)
if (EGVAR(main,hasACEInteractMenu)) then {
	[] call FUNC(addACEInteractMenu);
} else {
	player addEventHandler ["GetInMan", {_this call FUNC(getInAddAction)}];

	if !(vehicle player isEqualTo player) then {
		[player, "", vehicle player, []] call FUNC(getInAddAction);
	};
};
