#include "script_component.hpp"

// init global variables
GVAR(frameInterval) = 1;
GVAR(throttleClimbRate) = 0.4;
GVAR(throttleDropRate) = 0.7;
GVAR(pylonDragRatio) = 0.001; // Cd 0.1 for FIR Mk84
GVAR(massStandardRatio) = 0.8;
GVAR(fuelFlowMultiplierGlobal) = 1;
GVAR(thrustMultiplierGlobal) = 1;
GVAR(liftMultiplierGlobal) = 1;
GVAR(dragMultiplierGlobal) = 1;
GVAR(dragSourceMultiplier) = [1.0, 0.1, 1.0];
GVAR(thrustFactor) = 3.6;
GVAR(liftGFactor) = 2.5;
GVAR(waveCdArray) = [0.7, 0.98, 1.0, 1.03, 2.4, 0.2, 0.1, -3.5];
GVAR(wingHeight) = 1;
GVAR(wingSpan) = 12;
GVAR(geFactor) = 0.1;
GVAR(geLiftMultiplier) = 0.6;
GVAR(geInducedDragMultiplier) = 0.6;
GVAR(noForceoOnGround) = false;
GVAR(applyForce) = true;
GVAR(compensateCrabLanding) = true;

// add EventHandlers
addMissionEventHandler ["EachFrame", {[] call FUNC(eachFrameHandler)}];

["Plane", "Init", {_this call FUNC(vehicleInit)}, true, [], true] call CBA_fnc_addClassEventHandler;
// ["Plane", "LandedTouchDown", {_this call FUNC(eventTouchdown)}, true, [], true] call CBA_fnc_addClassEventHandler;
