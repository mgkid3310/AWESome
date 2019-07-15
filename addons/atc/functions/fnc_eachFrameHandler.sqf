#include "script_component.hpp"

private _timeOld = missionNamespace getVariable [QGVAR(timeOld), -1];
private _frameOld = missionNamespace getVariable [QGVAR(frameOld), -1];

if (!(alive player) || (_timeOld < 0) || (_frameOld < 0)) exitWith {
	missionNamespace setVariable [QGVAR(timeOld), time];
	missionNamespace setVariable [QGVAR(frameOld), diag_frameNo];
};

private _isUsingRadar = player getVariable [QGVAR(isUsingRadar), false];
private _replayParam = player getVariable [QGVAR(replayParam), []];

};

if (_isUsingRadar) then {
	_radarScreenParam call FUNC(atcRadarLoop);
};

[] call FUNC(periodicCheck);

missionNamespace setVariable [QGVAR(timeOld), time];
missionNamespace setVariable [QGVAR(frameOld), diag_frameNo];
