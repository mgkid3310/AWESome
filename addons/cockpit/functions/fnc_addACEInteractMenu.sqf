#include "script_component.hpp"

private _checklistMain = [
	"checklistMain",
	localize LSTRING(checklistMain),
	"",
	{["none"] call FUNC(openChecklist)},
	{[_player, _target, 1] call EFUNC(main,isCrew)},
	{},
	[],
	[0, 0, 0],
	10
];
private _openChecklist01 = [
	"openChecklist01",
	localize LSTRING(openChecklist01),
	"",
	{["pre_start_checklist"] call FUNC(openChecklist)},
	{([_player, _target, 1] call EFUNC(main,isCrew)) && !(GVAR(currentChecklist) isEqualTo "pre_start_checklist")},
	{},
	[],
	[0, 0, 0],
	10
];
private _openChecklist02 = [
	"openChecklist02",
	localize LSTRING(openChecklist02),
	"",
	{["startup_before_taxi_checklist"] call FUNC(openChecklist)},
	{([_player, _target, 1] call EFUNC(main,isCrew)) && !(GVAR(currentChecklist) isEqualTo "startup_before_taxi_checklist")},
	{},
	[],
	[0, 0, 0],
	10
];
private _openChecklist03 = [
	"openChecklist03",
	localize LSTRING(openChecklist03),
	"",
	{["before_takeoff_checklist"] call FUNC(openChecklist)},
	{([_player, _target, 1] call EFUNC(main,isCrew)) && !(GVAR(currentChecklist) isEqualTo "before_takeoff_checklist")},
	{},
	[],
	[0, 0, 0],
	10
];
private _openChecklist04 = [
	"openChecklist04",
	localize LSTRING(openChecklist04),
	"",
	{["takeoff_checklist"] call FUNC(openChecklist)},
	{([_player, _target, 1] call EFUNC(main,isCrew)) && !(GVAR(currentChecklist) isEqualTo "takeoff_checklist")},
	{},
	[],
	[0, 0, 0],
	10
];
private _openChecklist05 = [
	"openChecklist05",
	localize LSTRING(openChecklist05),
	"",
	{["descent_approach_checklist"] call FUNC(openChecklist)},
	{([_player, _target, 1] call EFUNC(main,isCrew)) && !(GVAR(currentChecklist) isEqualTo "descent_approach_checklist")},
	{},
	[],
	[0, 0, 0],
	10
];
private _openChecklist06 = [
	"openChecklist06",
	localize LSTRING(openChecklist06),
	"",
	{["landing_taxi_to_ramp_checklist"] call FUNC(openChecklist)},
	{([_player, _target, 1] call EFUNC(main,isCrew)) && !(GVAR(currentChecklist) isEqualTo "landing_taxi_to_ramp_checklist")},
	{},
	[],
	[0, 0, 0],
	10
];
private _closeChecklist = [
	"closeChecklist",
	localize LSTRING(closeChecklist),
	"",
	{["none"] call FUNC(openChecklist)},
	{([_player, _target, 1] call EFUNC(main,isCrew)) && !(GVAR(currentChecklist) isEqualTo "none")},
	{},
	[],
	[0, 0, 0],
	10
];

EGVAR(main,ACEInteractions) pushBack [5, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome"],
	_checklistMain,
	true
]];
EGVAR(main,ACEInteractions) pushBack [5.1, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "checklistMain"],
	_openChecklist01,
	true
]];
EGVAR(main,ACEInteractions) pushBack [5.2, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "checklistMain"],
	_openChecklist02,
	true
]];
EGVAR(main,ACEInteractions) pushBack [5.3, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "checklistMain"],
	_openChecklist03,
	true
]];
EGVAR(main,ACEInteractions) pushBack [5.4, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "checklistMain"],
	_openChecklist04,
	true
]];
EGVAR(main,ACEInteractions) pushBack [5.5, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "checklistMain"],
	_openChecklist05,
	true
]];
EGVAR(main,ACEInteractions) pushBack [5.6, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "checklistMain"],
	_openChecklist06,
	true
]];
EGVAR(main,ACEInteractions) pushBack [5.7, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "checklistMain"],
	_closeChecklist,
	true
]];
