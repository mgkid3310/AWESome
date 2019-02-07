// init global variable
awesome_cockpit_lastChecklist = "pre_start_checklist";
awesome_cockpit_currentChecklist = "none";
awesome_cockpit_checklistArray = ["pre_start_checklist",
    "startup_before_taxi_checklist",
    "before_takeoff_checklist",
    "takeoff_checklist",
    "descent_approach_checklist",
    "landing_taxi_to_ramp_checklist"
];

awesome_cockpit_speedShakeMultiplier = 0.0001;
awesome_cockpit_speedMaxShake = 600;
awesome_cockpit_groundShakeMultiplier = 15;
awesome_cockpit_touchdownShakeMultiplier = 0.8;

// add EventHandlers
addMissionEventHandler ["EachFrame", {[] call awesome_cockpit_fnc_eachFrameHandler}];

// add actions (ACE / vanilla)
if (awesome_awesome_hasACEInteractMenu) then {
    [] call awesome_cockpit_fnc_addACEInteractMenu;
} else {
    player addEventHandler ["GetInMan", {_this call awesome_cockpit_fnc_getInAddAction}];

    if !(vehicle player isEqualTo player) then {
    	[player, "", vehicle player, []] call awesome_cockpit_fnc_getInAddAction;
    };
};
