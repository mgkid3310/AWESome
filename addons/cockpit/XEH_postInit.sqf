#include "script_component.hpp"

// init global variables
GVAR(lastChecklist) = "pre_start_checklist";
GVAR(currentChecklist) = "none";
GVAR(checklistArray) = [
	"pre_start_checklist",
	"startup_before_taxi_checklist",
	"before_takeoff_checklist",
	"takeoff_checklist",
	"descent_approach_checklist",
	"landing_taxi_to_ramp_checklist"
];

GVAR(speedMaxShake) = 600;
GVAR(groundShake) = 0.0015;
GVAR(speedShake) = 0.00005;
GVAR(touchdownShake) = 0.8;

// add EventHandlers
addMissionEventHandler ["EachFrame", {[] call FUNC(eachFrameHandler)}];
