#include "script_component.hpp"

params ["_screen"];

if (EGVAR(main,hasACEInteractMenu)) then {
	private _actionRadarStart = [
		"startATCradar",
		"Watch ATC Radar Screen",
		"",
		{_this call FUNC(radarScreenOn)},
		{!(_player getVariable [QGVAR(isUsingRadar), false])},
		{},
		[],
		[0, 0, 0],
		10
	] call ace_interact_menu_fnc_createAction;
	private _actionRadarStop = [
		"stopATCradar",
		"Stop Watching Radar Screen",
		"",
		{_this call FUNC(radarScreenOff)},
		{_player getVariable [QGVAR(isUsingRadar), false]},
		{},
		[],
		[0, 0, 0],
		10
	] call ace_interact_menu_fnc_createAction;

	[_screen, 0, ["ACE_MainActions", "AWESome"], _actionRadarStart] call ace_interact_menu_fnc_addActionToObject;
	[_screen, 0, ["ACE_MainActions", "AWESome"], _actionRadarStop] call ace_interact_menu_fnc_addActionToObject;
} else {
	_screen addAction ["Watch ATC Radar Screen", {_this call FUNC(radarScreenOn)}, nil, 1.011, true, true, "", "!(_this getVariable ['orbis_atc_isUsingRadar', false])", 5];
	_screen addAction ["Stop Watching Radar Screen", {_this call FUNC(radarScreenOff)}, nil, 1.011, false, true, "", "_this getVariable ['orbis_atc_isUsingRadar', false]", 5];
};
