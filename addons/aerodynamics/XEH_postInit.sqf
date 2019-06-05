#include "script_component.hpp"

// init global variables
GVAR(frameInterval) = 1;
GVAR(pylonDragRatio) = 0.001; // Cd 0.1 for FIR Mk84
GVAR(massStandardRatio) = 0.8;
GVAR(dragMultiplier) = 1;
GVAR(thrustMultiplier) = 1;
GVAR(altitudeMultiplier) = 1;
GVAR(dragSourceMultiplier) = [1.0, 0.1, 1.0];
GVAR(thrustFactor) = 7.2;
GVAR(liftGFactor) = 2.5;
GVAR(waveCdArray) = [0.7, 0.98, 1.0, 1.03, 2.4, 0.2, 0.1, -3.5];
GVAR(wingHeight) = 1;
GVAR(wingSpan) = 12;
GVAR(geFactor) = 0.1;
GVAR(geLiftMultiplier) = 0.6;
GVAR(geInducedDragMultiplier) = 0.6;
GVAR(noForceoOnGround) = false;

// add EventHandlers
player addEventHandler ["GetInMan", {_this call FUNC(eventGetInMan)}];
addMissionEventHandler ["EachFrame", {[] call FUNC(eachFrameHandler)}];

if !(vehicle player isEqualTo player) then {
	[player, "", vehicle player, []] call FUNC(eventGetInMan);
};

["Plane", "init", {_this call FUNC(vehicleInit)}, true, [], true] call CBA_fnc_addClassEventHandler;
