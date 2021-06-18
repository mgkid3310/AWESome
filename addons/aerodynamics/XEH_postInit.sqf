#include "script_component.hpp"

// init global variables
GVAR(frameInterval) = 1;
GVAR(gridResolution) = 0; // 2
GVAR(gridSizeX) = 12;
GVAR(gridSizeY) = 16;
GVAR(showSamplingGrid) = false;
GVAR(maxWindVariability) = 0.4;
GVAR(windWavelength) = 60;
GVAR(gustChance) = 0.3;
GVAR(maxGustDuration) = 240;
GVAR(gustMultiplier) = 1.5;
GVAR(throttleClimbRate) = 0.4;
GVAR(throttleDropRate) = 0.7;
GVAR(pylonDragRatio) = 0.002; // 0.5*Cd*A*rho = 0.12 for FIR Mk84 (0.06, 1000kg)
GVAR(massStandardRatio) = 0.8;
GVAR(fuelFlowMultiplierGlobal) = 1;
GVAR(thrustMultiplierGlobal) = 1;
GVAR(liftMultiplierGlobal) = 1;
GVAR(dragMultiplierGlobal) = 1;
GVAR(dragSourceMultiplier) = [0.8, 0.1, 0.8];
GVAR(thrustFactor) = 0.152;
GVAR(vtolThrustFactor) = [0.21, 0.5, 1.8, 1.0];
GVAR(liftGFactor) = 2.5;
GVAR(liftFlapFactor) = [0.27, 0.5, 3.0, 0.5];
GVAR(waveCdArray) = [0.7, 0.98, 1.0, 1.03, 2.4, 0.2, 0.1, -3.5];
GVAR(minStallSpeed) = 10;
GVAR(wingHeight) = 1;
GVAR(wingSpan) = 12;
GVAR(geFactor) = 0.1;
GVAR(geLiftMultiplier) = 0.6;
GVAR(geInducedDragMultiplier) = 0.6;
GVAR(noForceOnGround) = false;
GVAR(applyForce) = true;
GVAR(compensateCrabLanding) = true;

// add EventHandlers
addMissionEventHandler ["EachFrame", {[] call FUNC(eachFrameHandler)}];

["Plane", "Init", {_this call FUNC(vehicleInit)}, true, [], true] call CBA_fnc_addClassEventHandler;
// ["Plane", "LandedTouchDown", {_this call FUNC(eventTouchdown)}, true, [], true] call CBA_fnc_addClassEventHandler;
