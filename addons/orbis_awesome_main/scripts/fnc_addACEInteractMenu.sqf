private _actionMain = [
	"AWESome",
	"AWESome",
	"",
	{},
	{[] call orbis_awesome_fnc_isCrew},
	{},
	[],
	[0, 0, 0],
	10
];

orbis_awesome_ACEInteractions pushBack [0, [
	"Plane",
	1,
	["ACE_SelfActions"],
	_actionMain,
    true
]];
orbis_awesome_ACEInteractions pushBack [0, [
	"Helicopter",
	1,
	["ACE_SelfActions"],
	_actionMain,
    true
]];
