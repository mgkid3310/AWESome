private _actionATISmain = [
	"actionATIS",
	"ATIS",
	"",
	{},
	{[] call orbis_awesome_fnc_isCrew},
	{},
	[],
	[0, 0, 0],
	10
];
private _actionATISlisten = [
	"startATIS",
	"Listen to ATIS",
	"",
	{[] call orbis_atc_fnc_listenATISbroadcast},
	{([] call orbis_awesome_fnc_isCrew) && (_target getVariable ["orbisATISready", true])},
	{},
	[],
	[0, 0, 0],
	10
];
private _actionATISstop = [
	"stopATIS",
	"Stop Listening ATIS",
	"",
	{_target setVariable ["orbisATISstop", true, true]},
	{([] call orbis_awesome_fnc_isCrew) && !(_target getVariable ["orbisATISstop", true])},
	{},
	[],
	[0, 0, 0],
	10
];

// planes
orbis_awesome_ACEInteractions pushBack [4, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome"],
	_actionATISmain,
	true
]];
orbis_awesome_ACEInteractions pushBack [4.1, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "actionATIS"],
	_actionATISlisten,
	true
]];
orbis_awesome_ACEInteractions pushBack [4.2, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "actionATIS"],
	_actionATISstop,
	true
]];

// helicopters
orbis_awesome_ACEInteractions pushBack [4, [
	"Helicopter",
	1,
	["ACE_SelfActions", "AWESome"],
	_actionATISmain,
	true
]];
orbis_awesome_ACEInteractions pushBack [4.1, [
	"Helicopter",
	1,
	["ACE_SelfActions", "AWESome", "actionATIS"],
	_actionATISlisten,
	true
]];
orbis_awesome_ACEInteractions pushBack [4.2, [
	"Helicopter",
	1,
	["ACE_SelfActions", "AWESome", "actionATIS"],
	_actionATISstop,
	true
]];
