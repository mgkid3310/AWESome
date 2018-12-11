// init global variable
orbis_cockpit_lastChecklist = "pre_start_checklist";
orbis_cockpit_currentChecklist = "none";
orbis_cockpit_checklistArray = ["pre_start_checklist",
    "startup_before_taxi_checklist",
    "before_takeoff_checklist",
    "takeoff_checklist",
    "descent_approach_checklist",
    "landing_taxi_to_ramp_checklist"
];

orbis_cockpit_speedShakeMultiplier = 0.0001;
orbis_cockpit_speedMaxShake = 600;
orbis_cockpit_groundShakeMultiplier = 25;
orbis_cockpit_touchdownShakeMultiplier = 0.8;

// add EventHandlers
addMissionEventHandler ["EachFrame", {[] call orbis_cockpit_fnc_eachFrameHandler}];

// add actions (ACE / vanilla)
if (orbis_awesome_hasACEInteractMenu) then {
    [] call orbis_cockpit_fnc_addACEInteractMenu;
} else {
    player addEventHandler ["GetInMan", {_this call orbis_cockpit_fnc_getInAddAction}];

    if !(vehicle player isEqualTo player) then {
    	[player, "", vehicle player, []] call orbis_cockpit_fnc_getInAddAction;
    };
};
