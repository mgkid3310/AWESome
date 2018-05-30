private _actionGPWSmodes = [
	"orbisGPWSmodes",
	"GPWS",
	"",
	{},
	{(_player in [driver _target, gunner _target, commander _target]) && (_target getVariable ["orbisGPWSenabled", false])},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _actionTurnOff = [
	"turnOff",
	"Turn off GPWS",
	"",
	{[_target, "", true] call orbis_gpws_fnc_startGPWS},
	{(_player in [driver _target, gunner _target, commander _target]) && (_target getVariable ["orbisGPWSenabled", false]) && (_target getVariable ["orbisGPWSmode", ""] != "")},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _actionF16 = [
	"f16",
	"Set to Betty (F-16)",
	"",
	{[_target, "f16", true] call orbis_gpws_fnc_startGPWS},
	{(_player in [driver _target, gunner _target, commander _target]) && (_target getVariable ["orbisGPWSenabled", false]) && (_target getVariable ["orbisGPWSmode", ""] != "f16")},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _testF16 = [
	"f16Test",
	"Test GPWS (Betty)",
	"",
	{[_target] spawn orbis_gpws_fnc_f16GPWStest},
	{(_player in [driver _target, gunner _target, commander _target]) && (_target getVariable ["orbisGPWSenabled", false]) && (_target getVariable ["orbisGPWSmode", ""] == "f16") && (_target getVariable ["orbisGPWStestReady", true])},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _actionB747 = [
	"b747",
	"Set to B747 GPWS",
	"",
	{[_target, "b747", true] call orbis_gpws_fnc_startGPWS},
	{(_player in [driver _target, gunner _target, commander _target]) && (_target getVariable ["orbisGPWSenabled", false]) && (_target getVariable ["orbisGPWSmode", ""] != "b747")},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _testB747 = [
	"f16Test",
	"Test GPWS (B747)",
	"",
	{[_target] spawn orbis_gpws_fnc_b747GPWStest},
	{(_player in [driver _target, gunner _target, commander _target]) && (_target getVariable ["orbisGPWSenabled", false]) && (_target getVariable ["orbisGPWSmode", ""] == "b747") && (_target getVariable ["orbisGPWStestReady", true])},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _actionVolumeLow = [
	"volumeLow",
	"Lower Volume",
	"",
	{_target setVariable ["orbisGPWSvolumeLow", true, true]},
	{(_player in [driver _target, gunner _target, commander _target]) && (_target getVariable ["orbisGPWSenabled", false]) && !(_target getVariable ["orbisGPWSvolumeLow", false])},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _actionVolumeHigh = [
	"volumeHigh",
	"Increase Volume",
	"",
	{_target setVariable ["orbisGPWSvolumeLow", false, true]},
	{(_player in [driver _target, gunner _target, commander _target]) && (_target getVariable ["orbisGPWSenabled", false]) && (_target getVariable ["orbisGPWSvolumeLow", false])},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;

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
[
	"Plane",
	1,
	["ACE_SelfActions", "orbisGPWSmodes"],
	_actionB747,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Plane",
	1,
	["ACE_SelfActions", "orbisGPWSmodes"],
	_testB747,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Plane",
	1,
	["ACE_SelfActions", "orbisGPWSmodes"],
	_actionVolumeLow,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Plane",
	1,
	["ACE_SelfActions", "orbisGPWSmodes"],
	_actionVolumeHigh,
    true
] call ace_interact_menu_fnc_addActionToClass;
