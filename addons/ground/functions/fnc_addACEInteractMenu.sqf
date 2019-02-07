// towbar actions
private _deployTowBar = [
	"deployTowBar",
	"Deploy Towbar",
	"",
	{[_target] call awesome_ground_fnc_deployTowBar},
	{!(_target getVariable ['awesome_hasTowBarDeployed', false]) && (abs (speed _target) < 1)},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _removeTowBar = [
	"removeTowBar",
	"Remove Towbar",
	"",
	{[_target] call awesome_ground_fnc_removeTowBar},
	{(_target getVariable ['awesome_hasTowBarDeployed', false]) && (abs (speed _target) < 1)},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;

[
	"Offroad_01_base_F",
	0,
	["ACE_MainActions"],
	_deployTowBar,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Offroad_01_base_F",
	0,
	["ACE_MainActions"],
	_removeTowBar,
    true
] call ace_interact_menu_fnc_addActionToClass;

// parking brake interactions
/* private _parkingBrakeSet = [
	"parkingBrakeSet",
	"Set Parking Brake",
	"",
	{[_target] call awesome_ground_fnc_parkingBrakeSet},
	{([nil, nil, 1] call awesome_awesome_fnc_isCrew) && !(_target getVariable ['awesome_parkingBrakeSet', false]) && (abs (speed _target) < 1)},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _parkingBrakeRelease = [
	"parkingBrakeRelease",
	"Release Parking Brake",
	"",
	{[_target] call awesome_ground_fnc_parkingBrakeRelease},
	{([nil, nil, 1] call awesome_awesome_fnc_isCrew) && (_target getVariable ['awesome_parkingBrakeSet', true])},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;

[
	"Plane",
	1.1,
	["ACE_SelfActions"],
	_parkingBrakeSet,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Plane",
	1.1,
	["ACE_SelfActions"],
	_parkingBrakeRelease,
    true
] call ace_interact_menu_fnc_addActionToClass; */
