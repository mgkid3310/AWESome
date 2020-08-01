#include "script_component.hpp"

params ["_monitor"];

if (EGVAR(main,hasACEInteractMenu)) then {
	private _actionATISmain = [
		"actionATISconsole",
		"ATIS",
		"",
		{},
		{true},
		{},
		[],
		[0, 0, 0],
		10
	] call ace_interact_menu_fnc_createAction;
	private _actionATISupdate = [
		"updateATISdata",
		"Update ATIS data",
		"",
		{[true, true, _this select 0] call FUNC(updateATISdata)},
		{true},
		{},
		[],
		[0, 0, 0],
		10
	] call ace_interact_menu_fnc_createAction;
	private _actionATISlisten = [
		"startATIS",
		"Listen to ATIS",
		"",
		{[_this select 1, -1] call FUNC(listenATISbroadcast)},
		{_player getVariable [QGVAR(isATISready), true]},
		{},
		[],
		[0, 0, 0],
		10
	] call ace_interact_menu_fnc_createAction;
	private _actionATISstop = [
		"stopATIS",
		"Stop Listening to ATIS",
		"",
		{(_this select 1) setVariable [QGVAR(stopATIS), true, true]},
		{!(_player getVariable [QGVAR(orbis_atc_stopATIS), true])},
		{},
		[],
		[0, 0, 0],
		10
	] call ace_interact_menu_fnc_createAction;

	[_monitor, 0, ["ACE_MainActions"], _actionATISmain] call ace_interact_menu_fnc_addActionToObject;
	[_monitor, 0, ["ACE_MainActions", "actionATISconsole"], _actionATISupdate] call ace_interact_menu_fnc_addActionToObject;
	[_monitor, 0, ["ACE_MainActions", "actionATISconsole"], _actionATISlisten] call ace_interact_menu_fnc_addActionToObject;
	[_monitor, 0, ["ACE_MainActions", "actionATISconsole"], _actionATISstop] call ace_interact_menu_fnc_addActionToObject;
} else {
	_monitor addAction ["Update ATIS data", {[true, true, _this select 0] call FUNC(updateATISdata)}, nil, 1.012, true, true, "", "", 5];
	_monitor addAction ["Listen to ATIS", {[_this select 1, -1] call FUNC(listenATISbroadcast)}, nil, 1.013, false, true, "", "_this getVariable ['orbis_atc_isATISready', true]", 10];
	_monitor addAction ["Stop Listening to ATIS", {(_this select 1) setVariable [QGVAR(stopATIS), true, true]}, nil, 1.013, false, true, "", "!(_this getVariable ['orbis_atc_stopATIS', true])", 10];
};
