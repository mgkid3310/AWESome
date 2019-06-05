#include "script_component.hpp"

private _vehicle = vehicle player;
private _timeOld = missionNamespace getVariable [QGVAR(timeOld), -1];

if ((_vehicle isEqualTo player) || (_timeOld < 0)) exitWith {
	missionNamespace setVariable [QGVAR(timeOld), time];
};

if (_vehicle isKindOf "Plane") then {
	[_vehicle, player, _timeOld] call FUNC(headShakeLoop);
};

missionNamespace setVariable [QGVAR(timeOld), time];
