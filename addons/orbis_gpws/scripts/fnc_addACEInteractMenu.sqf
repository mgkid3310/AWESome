private _actionGPWSmodes = [
	"orbisGPWSmodes",
	"GPWS Modes",
	"",
	{},
	{(_player isEqualTo driver _target) && (_target getVariable ['orbisGPWSenabled', false])},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _actionTurnOff = [
	"turnOff",
	"Turn off GPWS",
	"",
	{_target setVariable ['orbisGPWSmode', '']},
	{(_player isEqualTo driver _target) && (_target getVariable ['orbisGPWSenabled', false]) && (_target getVariable ['orbisGPWSmode', ''] != '')},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _actionF16 = [
	"f16",
	"Set to Betty (F-16)",
	"",
	{[_this select 0] spawn orbis_gpws_fnc_f16GPWS},
	{(_player isEqualTo driver _target) && (_target getVariable ['orbisGPWSenabled', false]) && (_target getVariable ['orbisGPWSmode', ''] != 'f16')},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _testF16 = [
	"f16",
	"Test GPWS",
	"",
	{[_this select 0] spawn orbis_gpws_fnc_f16GPWStest},
	{(_player isEqualTo driver _target) && (_target getVariable ['orbisGPWSenabled', false]) && (_target getVariable ['orbisGPWSmode', ''] == 'f16')},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
/* private _actionB747 = [
	"b747",
	"Set to B747 GPWS",
	"",
	{[_this select 0] spawn orbis_gpws_fnc_b747GPWS},
	{(_player isEqualTo driver _target) && (_target getVariable ['orbisGPWSenabled', false]) && (_target getVariable ['orbisGPWSmode', ''] != 'b747')},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction; */

[
	"Plane",
	1,
	["ACE_SelfActions"],
	_actionGPWSmodes,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Plane",
	1,
	["ACE_SelfActions", "orbisGPWSmodes"],
	_actionTurnOff,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Plane",
	1,
	["ACE_SelfActions", "orbisGPWSmodes"],
	_actionF16,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Plane",
	1,
	["ACE_SelfActions", "orbisGPWSmodes"],
	_testF16,
    true
] call ace_interact_menu_fnc_addActionToClass;
/* [
	"Plane",
	1,
	["ACE_SelfActions", "orbisGPWSmodes"],
	_actionB747,
    true
] call ace_interact_menu_fnc_addActionToClass; */
