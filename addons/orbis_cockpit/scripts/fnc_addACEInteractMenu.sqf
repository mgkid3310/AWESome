private _checklistMain = [
	"checklistMain",
	"Open Checklist",
	"",
	{},
	{[nil, nil, 1] call orbis_awesome_fnc_isCrew},
	{},
	[],
	[0, 0, 0],
	10
];
private _openChecklist01 = [
	"openChecklist01",
	"Pre-Start",
	"",
	{["pre_start_checklist"] call orbis_cockpit_fnc_openChecklist},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && !(orbis_cockpit_currentChecklist isEqualTo "pre_start_checklist")},
	{},
	[],
	[0, 0, 0],
	10
];
private _openChecklist02 = [
	"openChecklist02",
	"Startup + Before Taxi",
	"",
	{["startup_before_taxi_checklist"] call orbis_cockpit_fnc_openChecklist},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && !(orbis_cockpit_currentChecklist isEqualTo "startup_before_taxi_checklist")},
	{},
	[],
	[0, 0, 0],
	10
];
private _openChecklist03 = [
	"openChecklist03",
	"Before Takeoff",
	"",
	{["before_takeoff_checklist"] call orbis_cockpit_fnc_openChecklist},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && !(orbis_cockpit_currentChecklist isEqualTo "before_takeoff_checklist")},
	{},
	[],
	[0, 0, 0],
	10
];
private _openChecklist04 = [
	"openChecklist04",
	"Takeoff",
	"",
	{["takeoff_checklist"] call orbis_cockpit_fnc_openChecklist},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && !(orbis_cockpit_currentChecklist isEqualTo "takeoff_checklist")},
	{},
	[],
	[0, 0, 0],
	10
];
private _openChecklist05 = [
	"openChecklist05",
	"Descent + Approach",
	"",
	{["descent_approach_checklist"] call orbis_cockpit_fnc_openChecklist},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && !(orbis_cockpit_currentChecklist isEqualTo "descent_approach_checklist")},
	{},
	[],
	[0, 0, 0],
	10
];
private _openChecklist06 = [
	"openChecklist06",
	"Landing + Taxi To Ramp",
	"",
	{["landing_taxi_to_ramp_checklist"] call orbis_cockpit_fnc_openChecklist},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && !(orbis_cockpit_currentChecklist isEqualTo "landing_taxi_to_ramp_checklist")},
	{},
	[],
	[0, 0, 0],
	10
];
private _closeChecklist = [
	"closeChecklist",
	"Close Checklist",
	"",
	{["none"] call orbis_cockpit_fnc_openChecklist},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && !(orbis_cockpit_currentChecklist isEqualTo "none")},
	{},
	[],
	[0, 0, 0],
	10
];

orbis_awesome_ACEInteractions pushBack [1, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome"],
	_checklistMain,
    true
]];
orbis_awesome_ACEInteractions pushBack [1.1, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "checklistMain"],
	_openChecklist01,
    true
]];
orbis_awesome_ACEInteractions pushBack [1.2, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "checklistMain"],
	_openChecklist02,
    true
]];
orbis_awesome_ACEInteractions pushBack [1.3, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "checklistMain"],
	_openChecklist03,
    true
]];
orbis_awesome_ACEInteractions pushBack [1.4, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "checklistMain"],
	_openChecklist04,
    true
]];
orbis_awesome_ACEInteractions pushBack [1.5, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "checklistMain"],
	_openChecklist05,
    true
]];
orbis_awesome_ACEInteractions pushBack [1.6, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "checklistMain"],
	_openChecklist06,
    true
]];
orbis_awesome_ACEInteractions pushBack [1.7, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "checklistMain"],
	_closeChecklist,
    true
]];
