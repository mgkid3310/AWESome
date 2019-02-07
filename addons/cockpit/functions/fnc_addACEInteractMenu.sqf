private _checklistMain = [
	"checklistMain",
	"Open Checklist",
	"",
	{},
	{[nil, nil, 1] call awesome_awesome_fnc_isCrew},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _openChecklist01 = [
	"openChecklist01",
	"Pre-Start",
	"",
	{["pre_start_checklist"] call awesome_cockpit_fnc_openChecklist},
	{([nil, nil, 1] call awesome_awesome_fnc_isCrew) && !(awesome_cockpit_currentChecklist isEqualTo "pre_start_checklist")},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _openChecklist02 = [
	"openChecklist02",
	"Startup + Before Taxi",
	"",
	{["startup_before_taxi_checklist"] call awesome_cockpit_fnc_openChecklist},
	{([nil, nil, 1] call awesome_awesome_fnc_isCrew) && !(awesome_cockpit_currentChecklist isEqualTo "startup_before_taxi_checklist")},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _openChecklist03 = [
	"openChecklist03",
	"Before Takeoff",
	"",
	{["before_takeoff_checklist"] call awesome_cockpit_fnc_openChecklist},
	{([nil, nil, 1] call awesome_awesome_fnc_isCrew) && !(awesome_cockpit_currentChecklist isEqualTo "before_takeoff_checklist")},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _openChecklist04 = [
	"openChecklist04",
	"Takeoff",
	"",
	{["takeoff_checklist"] call awesome_cockpit_fnc_openChecklist},
	{([nil, nil, 1] call awesome_awesome_fnc_isCrew) && !(awesome_cockpit_currentChecklist isEqualTo "takeoff_checklist")},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _openChecklist05 = [
	"openChecklist05",
	"Descent + Approach",
	"",
	{["descent_approach_checklist"] call awesome_cockpit_fnc_openChecklist},
	{([nil, nil, 1] call awesome_awesome_fnc_isCrew) && !(awesome_cockpit_currentChecklist isEqualTo "descent_approach_checklist")},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _openChecklist06 = [
	"openChecklist06",
	"Landing + Taxi To Ramp",
	"",
	{["landing_taxi_to_ramp_checklist"] call awesome_cockpit_fnc_openChecklist},
	{([nil, nil, 1] call awesome_awesome_fnc_isCrew) && !(awesome_cockpit_currentChecklist isEqualTo "landing_taxi_to_ramp_checklist")},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _closeChecklist = [
	"closeChecklist",
	"Close Checklist",
	"",
	{["none"] call awesome_cockpit_fnc_openChecklist},
	{([nil, nil, 1] call awesome_awesome_fnc_isCrew) && !(awesome_cockpit_currentChecklist isEqualTo "none")},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;

[
	"Plane",
	1,
	["ACE_SelfActions", "AWESome"],
	_checklistMain,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "checklistMain"],
	_openChecklist01,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "checklistMain"],
	_openChecklist02,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "checklistMain"],
	_openChecklist03,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "checklistMain"],
	_openChecklist04,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "checklistMain"],
	_openChecklist05,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "checklistMain"],
	_openChecklist06,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "checklistMain"],
	_closeChecklist,
    true
] call ace_interact_menu_fnc_addActionToClass;
