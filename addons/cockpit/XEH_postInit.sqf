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
GVAR(speedShake) = 0.00003;
GVAR(touchdownShake) = 0.8;

// add EventHandlers
addMissionEventHandler ["EachFrame", {[] call FUNC(eachFrameHandler)}];

// add actions (vanilla)
if (hasInterface && !EGVAR(main,hasACEInteractMenu)) then {
	["CAManBase", "GetInMan", {
		if ((_this select 0) isEqualTo player) then {_this call FUNC(getInAddAction)};
	}] call CBA_fnc_addClassEventHandler;

	[{!isNull player}, {
		if !(vehicle player isEqualTo player) then {
			[player, "", vehicle player, []] call FUNC(getInAddAction);
		};
	}] call CBA_fnc_waitUntilAndExecute;
};
