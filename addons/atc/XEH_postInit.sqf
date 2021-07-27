#include "script_component.hpp"

missionNamespace setVariable [QGVAR(hasAWESomeATC_) + getPlayerUID player, true, true];

// set default radar parameter options
GVAR(radarParameterOptions) = [
	["ASR-11", [2.8, 1, 1.4, 5]],
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
	switch (toLower worldName) do {
		case ("tsau_earth_updated"): {
			GVAR(scaleStd) = GVAR(scaleStd) * 30720 / 102400;
		};
		default {
			GVAR(scaleStd) = GVAR(scaleStd) * 30720 / getNumber (configFile >> "CfgWorlds" >> worldName >> "mapSize");
		};
	};
};

GVAR(fontMax) = 0.1;
GVAR(fontMin) = 0.05;
GVAR(spaceMax) = 1.8;
GVAR(spaceMin) = 0.9;

GVAR(mapClickRange) = 300;

// add EventHandlers
[QGVAR(speakATIS), {_this spawn FUNC(speakATIS)}] call CBA_fnc_addEventHandler;
addMissionEventHandler ["EachFrame", {[] call FUNC(eachFrameHandler)}];
addMissionEventHandler ["MapSingleClick", {_this call FUNC(mapSingleClickHandler)}];
