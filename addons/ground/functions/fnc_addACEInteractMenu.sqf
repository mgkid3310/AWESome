#include "script_component.hpp"

// towbar actions
private _deployTowBar = [
	"deployTowBar",
	localize LSTRING(deployTowBar),
	"",
	{[_target] call FUNC(deployTowBar)},
	{!(_target getVariable [QGVAR(hasTowBarDeployed), false]) && (abs (speed _target) < 1)},
	{},
	[],
	[0, 0, 0],
	10
];
private _removeTowBar = [
	"removeTowBar",
	localize LSTRING(removeTowBar),
	"",
	{[_target] call FUNC(removeTowBar)},
	{(_target getVariable [QGVAR(hasTowBarDeployed), false]) && (abs (speed _target) < 1)},
	{},
	[],
	[0, 0, 0],
	10
];

EGVAR(main,ACEInteractions) pushBack [4.1, [
	"Offroad_01_base_F",
	0,
	["ACE_MainActions"],
	_deployTowBar,
	true
]];
EGVAR(main,ACEInteractions) pushBack [4.2, [
	"Offroad_01_base_F",
	0,
	["ACE_MainActions"],
	_removeTowBar,
	true
]];

// parking brake interactions
/* private _parkingBrakeSet = [
	"parkingBrakeSet",
	"Set Parking Brake",
	"",
	{[_target] call FUNC(parkingBrakeSet)},
	{([_player, _target, 1] call EFUNC(main,isCrew)) && !(_target getVariable [QGVAR(parkingBrakeSet), false]) && (abs (speed _target) < 1)},
	{},
	[],
	[0, 0, 0],
	10
];
private _parkingBrakeRelease = [
	"parkingBrakeRelease",
	"Release Parking Brake",
	"",
	{[_target] call FUNC(parkingBrakeRelease)},
	{([_player, _target, 1] call EFUNC(main,isCrew)) && (_target getVariable [QGVAR(parkingBrakeSet), true])},
	{},
	[],
	[0, 0, 0],
	10
];

EGVAR(main,ACEInteractions) pushBack [4.3, [
	"Plane",
	1.1,
	["ACE_SelfActions"],
	_parkingBrakeSet,
	true
]];
EGVAR(main,ACEInteractions) pushBack [4.4, [
	"Plane",
	1.1,
	["ACE_SelfActions"],
	_parkingBrakeRelease,
	true
]]; */
