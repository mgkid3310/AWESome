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
GVAR(terrainGamma) = 0.1; // -10dB, ground clutter reflectivity of constant gamma model
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

GVAR(scaleMax) = 0.1;
GVAR(scaleMin) = 0.05;
GVAR(spaceMax) = 1.8;
GVAR(spaceMin) = 0.9;

GVAR(mapClickRange) = 1.2;
GVAR(lineWidth) = 0.15;
GVAR(circleRadius) = 1.125;

// add EventHandlers
[QGVAR(spawnATIS), {_this spawn FUNC(spawnATIS)}] call CBA_fnc_addEventHandler;
addMissionEventHandler ["EachFrame", {[] call FUNC(eachFrameHandler)}];
addMissionEventHandler ["MapSingleClick", {_this call FUNC(mapSingleClickHandler)}];

// ATIS data update (server)
if (isServer) then {
	missionNamespace setVariable [QGVAR(serverUpdatesATIS), true, true];
	[{
		if !(GVAR(updateIntervalATIS) > 0) exitWith {};
		private _ATISdata = missionNamespace getVariable [QGVAR(ATISdata), false];
		if (!(_ATISdata isEqualType []) || {CBA_missionTime > (_ATISdata select 0 select 1) + GVAR(updateIntervalATIS) * 60}) then {
			[true, true] call FUNC(updateATISdata);
		};
	}, 1] call CBA_fnc_addPerFrameHandler;
};

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
