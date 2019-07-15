#include "script_component.hpp"

private _timeOld = missionNamespace getVariable [QGVAR(timeOld), -1];
private _frameOld = missionNamespace getVariable [QGVAR(frameOld), -1];

if (!(alive player) || (_timeOld < 0) || (_frameOld < 0)) exitWith {
	missionNamespace setVariable [QGVAR(timeOld), time];
	missionNamespace setVariable [QGVAR(frameOld), diag_frameNo];
};

private _isUsingRadar = player getVariable [QGVAR(isUsingRadar), false];
private _startRadarScreen = player getVariable [QGVAR(startRadarScreen), false];
private _radarScreenParam = player getVariable [QGVAR(radarScreenParam), []];

if (_startRadarScreen isEqualType []) then {
	_isUsingRadar = true;
	_radarScreenParam = _startRadarScreen;
	player setVariable [QGVAR(isUsingRadar), true];
	player setVariable [QGVAR(startRadarScreen), false];
	player setVariable [QGVAR(radarScreenParam), _radarScreenParam];
};

if (_isUsingRadar) then {
	_radarScreenParam call FUNC(atcRadarLoop);
};

[] call FUNC(periodicCheck);

missionNamespace setVariable [QGVAR(timeOld), time];
missionNamespace setVariable [QGVAR(frameOld), diag_frameNo];
