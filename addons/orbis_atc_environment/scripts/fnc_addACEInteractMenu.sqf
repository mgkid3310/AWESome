private _actionATISmain = [
	"actionATIS",
	"ATIS",
	"",
	{},
	{[] call orbis_awesome_main_fnc_isCrew},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _actionATISlisten = [
	"removeFlag",
	"Listen to ATIS",
	"",
	{[] call orbis_atc_fnc_listenATISbroadcast},
	{([] call orbis_awesome_main_fnc_isCrew) && (_target getVariable ["orbisATISready", true])},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _actionATISstop = [
	"stopATIS",
	"Stop Listening to ATIS",
	"",
	{_target setVariable ["orbisATISstop", true, true]},
	{([] call orbis_awesome_main_fnc_isCrew) && !(_target getVariable ["orbisATISstop", false])},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;

// planes
[
	"Plane",
	1,
	["ACE_SelfActions", "AWESome"],
	_actionATISmain,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "actionATIS"],
	_actionATISlisten,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "actionATIS"],
	_actionATISstop,
    true
] call ace_interact_menu_fnc_addActionToClass;

// helicopters
[
	"Helicopter",
	1,
	["ACE_SelfActions", "AWESome"],
	_actionATISmain,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Helicopter",
	1,
	["ACE_SelfActions", "AWESome", "actionATIS"],
	_actionATISlisten,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Helicopter",
	1,
	["ACE_SelfActions", "AWESome", "actionATIS"],
	_actionATISstop,
    true
] call ace_interact_menu_fnc_addActionToClass;
