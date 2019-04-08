// towbar actions
private _deployTowBar = [
	"deployTowBar",
	"Deploy Towbar",
	"",
	{[_target] call orbis_ground_fnc_deployTowBar},
	{!(_target getVariable ['orbis_hasTowBarDeployed', false]) && (abs (speed _target) < 1)},
	{},
	[],
	[0, 0, 0],
	10
];
private _removeTowBar = [
	"removeTowBar",
	"Remove Towbar",
	"",
	{[_target] call orbis_ground_fnc_removeTowBar},
	{(_target getVariable ['orbis_hasTowBarDeployed', false]) && (abs (speed _target) < 1)},
	{},
	[],
	[0, 0, 0],
	10
];

orbis_awesome_ACEInteractions pushBack [4.1, [
	"Offroad_01_base_F",
	0,
	["ACE_MainActions"],
	_deployTowBar,
    true
]];
orbis_awesome_ACEInteractions pushBack [4.2, [
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
	{[_target] call orbis_ground_fnc_parkingBrakeSet},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && !(_target getVariable ['orbis_parkingBrakeSet', false]) && (abs (speed _target) < 1)},
	{},
	[],
	[0, 0, 0],
	10
];
private _parkingBrakeRelease = [
	"parkingBrakeRelease",
	"Release Parking Brake",
	"",
	{[_target] call orbis_ground_fnc_parkingBrakeRelease},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && (_target getVariable ['orbis_parkingBrakeSet', true])},
	{},
	[],
	[0, 0, 0],
	10
];

orbis_awesome_ACEInteractions pushBack [4.3, [
	"Plane",
	1.1,
	["ACE_SelfActions"],
	_parkingBrakeSet,
    true
]];
orbis_awesome_ACEInteractions pushBack [4.4, [
	"Plane",
	1.1,
	["ACE_SelfActions"],
	_parkingBrakeRelease,
    true
]]; */
