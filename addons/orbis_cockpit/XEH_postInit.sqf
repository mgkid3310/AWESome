// init global variables
orbis_cockpit_lastChecklist = "pre_start_checklist";
orbis_cockpit_currentChecklist = "none";
orbis_cockpit_checklistArray = ["pre_start_checklist",
    "startup_before_taxi_checklist",
    "before_takeoff_checklist",
    "takeoff_checklist",
    "descent_approach_checklist",
    "landing_taxi_to_ramp_checklist"
];

orbis_cockpit_speedMaxShake = 600;
orbis_cockpit_groundShake = 0.0015;
orbis_cockpit_speedShake = 0.00005;
orbis_cockpit_touchdownShake = 0.8;

// add EventHandlers
addMissionEventHandler ["EachFrame", {[] call orbis_cockpit_fnc_eachFrameHandler}];
