#include "script_component.hpp"

params ["_throttle", "_paramDefault", "_paramThrust", "_speedMax", "_paramAltitude"];
_paramDefault params ["_modelvelocity", "_massCurrent", "_massError"];
_paramThrust params ["_thrustCoef", "_vtolMode", "_thrustMultiplier", "_engineDamage", "_thrustVector"];
_paramAltitude params ["_altFullForce", "_altNoForce", "_altitude"];

// if (_massError) exitWith {[0, 0, 0]};

private _speedKPH = (_modelvelocity select 1) * 3.6;
private _thrustValue = [_thrustCoef, _speedMax, 1.5 / (count _thrustCoef - 1), _speedKPH] call FUNC(extractCoefArray);
_thrustValue = _thrustValue * _throttle * linearConversion [_altFullForce, _altNoForce, _altitude, 1, 0, true];
_thrustValue = _thrustValue * (1 - _engineDamage) * GVAR(thrustFactor) * (sqrt _speedMax) * _massCurrent;

if (_vtolMode > 0) then {
	GVAR(vtolThrustFactor) params ["_speedL", "_speedH", "_factorL", "_factorH"];
	_thrustValue = _thrustValue * linearConversion [_speedL, _speedH, _speedKPH / _speedMax, _factorL, _factorH, true];
};

private _thrustVector = [0, _thrustValue * cos (_thrustVector * 90), _thrustValue * sin (_thrustVector * 90)];

_thrustVector
