#include "script_component.hpp"

player setVariable [QGVAR(hasAWESomeATC), true, true];

// set default radar parameter options
GVAR(radarParameterOptions) = [
	["AN/APG76", [16.5, 1.25, 2.2, 3.8]],
	["AN/APS145", [0.45, 13, 7, 20]]
];

// init global variables
GVAR(speedOfLight) = 299792458; // m/s
GVAR(volumeClutterFactor) = 1;
GVAR(groundClutterFactor) = 1;
GVAR(minRadarDetection) = 16; // maximum radar range x0.5

GVAR(minVerticalSpd) = 3.048; // 600ft/min

GVAR(xOffset) = 1.2;
GVAR(yOffset) = -0.4;

GVAR(scaleStd) = 0.0015;
if (isNumber (configFile >> "CfgWorlds" >> worldName >> "mapSize")) then {
	GVAR(scaleStd) = (GVAR(scaleStd) * 30720) / getNumber (configFile >> "CfgWorlds" >> worldName >> "mapSize");
};
GVAR(fontMax) = 0.1;
GVAR(fontMin) = 0.05;
GVAR(spaceMax) = 1.8;
GVAR(spaceMin) = 0.9;

// run initial ATIS data update
[] spawn {
	sleep 10;
	[false] call FUNC(updateATISdata);
};

// add EventHandlers
[QGVAR(speakATIS), {_this spawn FUNC(speakATIS)}] call CBA_fnc_addEventHandler;
addMissionEventHandler ["EachFrame", {[] call FUNC(eachFrameHandler)}];
