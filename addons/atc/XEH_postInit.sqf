#include "script_component.hpp"

player setVariable [QGVAR(hasAWESomeATC), true, true];

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
addMissionEventHandler ["EachFrame", {[] call FUNC(eachFrameHandler)}];
