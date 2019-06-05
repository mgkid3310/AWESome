#include "script_component.hpp"

private _timeOld = missionNamespace getVariable [QGVAR(timeOld), -1];
private _frameOld = missionNamespace getVariable [QGVAR(frameOld), -1];

if (!(alive player) || (_timeOld < 0) || (_frameOld < 0)) exitWith {
	missionNamespace setVariable [QGVAR(timeOld), time];
	missionNamespace setVariable [QGVAR(frameOld), diag_frameNo];
};

private _isUsingRadarScreen = player getVariable [QGVAR(isUsingRadarScreen), false];
private _startRadarScreen = player getVariable [QGVAR(startRadarScreen), false];
private _radarScreenParam = player getVariable [QGVAR(radarScreenParam), []];

if (_startRadarScreen isEqualType []) then {
	_isUsingRadarScreen = true;
	_radarScreenParam = _startRadarScreen;
	player setVariable [QGVAR(isUsingRadarScreen), true, true];
	player setVariable [QGVAR(startRadarScreen), false, true];
	player setVariable [QGVAR(radarScreenParam), _radarScreenParam, true];
};

if (_isUsingRadarScreen) then {
	_radarScreenParam call FUNC(atcRadarLoop);
};

missionNamespace setVariable [QGVAR(timeOld), time];
missionNamespace setVariable [QGVAR(frameOld), diag_frameNo];
