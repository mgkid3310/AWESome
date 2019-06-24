#include "script_component.hpp"

private _vehicle = vehicle player;
private _timeOld = missionNamespace getVariable [QGVAR(timeOld), -1];
private _frameOld = missionNamespace getVariable [QGVAR(frameOld), -1];

if (!GVAR(enabled) || (_vehicle isEqualTo player) || (_timeOld < 0) || (_frameOld < 0)) exitWith {
	missionNamespace setVariable [QGVAR(timeOld), time];
	missionNamespace setVariable [QGVAR(frameOld), diag_frameNo];

	private _aeroConfigs = _vehicle getVariable [QGVAR(aeroConfig), false];
	if !(_aeroConfigs isEqualType []) then {
		_aeroConfigs = [_vehicle] call FUNC(getAeroConfig);
		_vehicle setVariable [QGVAR(aeroConfig), _aeroConfigs];
	};
	_vehicle setMass (_aeroConfigs select 3 select 1);
};
if (diag_frameNo < (_frameOld + GVAR(frameInterval))) exitWith {};

if ((driver _vehicle isEqualTo player) && (_vehicle isKindOf "Plane")) then {
	[_vehicle, _timeOld] call FUNC(fixedWingLoop);
};

missionNamespace setVariable [QGVAR(timeOld), time];
missionNamespace setVariable [QGVAR(frameOld), diag_frameNo];
