#include "script_component.hpp"

params ["_monitor", ["_radarMode", 1], ["_distance", 10]];

private _interactDistance = [10, 10 min _distance] select (_distance > 0);

if (EGVAR(main,hasACEInteractMenu)) then {
	private _actionRadarStart = [
		"startATCradar",
		"Watch ATC Radar Screen",
		"",
		{_this call FUNC(radarScreenOn)},
		{!(_player getVariable [QGVAR(isUsingRadar), false])},
		{},
		[_radarMode, _distance],
		[0, 0, 0],
		_interactDistance
	] call ace_interact_menu_fnc_createAction;
	private _actionRadarStop = [
		"stopATCradar",
		"Stop Watching Radar Screen",
		"",
		{_this call FUNC(radarScreenOff)},
		{_player getVariable [QGVAR(isUsingRadar), false]},
		{},
		[_radarMode, _distance],
		[0, 0, 0],
		_interactDistance
	] call ace_interact_menu_fnc_createAction;

	[_monitor, 0, ["ACE_MainActions"], _actionRadarStart] call ace_interact_menu_fnc_addActionToObject;
	[_monitor, 0, ["ACE_MainActions"], _actionRadarStop] call ace_interact_menu_fnc_addActionToObject;
} else {
	_monitor addAction ["Watch ATC Radar Screen", {[_this select 0, _this select 1, _this select 3] call FUNC(radarScreenOn)}, [_radarMode, _distance], 1.011, true, true, "", "!(_this getVariable ['orbis_atc_isUsingRadar', false])", 5];
	_monitor addAction ["Stop Watching Radar Screen", {[_this select 0, _this select 1, _this select 3] call FUNC(radarScreenOff)}, [_radarMode, _distance], 1.011, false, true, "", "_this getVariable ['orbis_atc_isUsingRadar', false]", 5];
};
