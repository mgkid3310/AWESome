#include "script_component.hpp"

params ["_paramEnhanced", "_paramThrust", "_speedMax", "_paramAtmosphere"];
_paramEnhanced params ["_trueAirVelocity", "_massStandard", "_massError", "_densityRatio", "_height"];
_paramThrust params ["_thrustCoef", "_vtolMode", "_thrustMultiplier", "_throttle", "_engineDamage", "_thrustVector"];
_paramAtmosphere params ["_temperatureRatio", "_pressureRatio"];

// if (_massError) exitWith {[0, 0, 0]};

private _speedKPH = (_modelvelocity select 1) * 3.6;
private _thrustValue = [_thrustCoef, _speedMax, 1.5 / (count _thrustCoef - 1), _speedKPH] call FUNC(extractCoefArray);
_thrustValue = _thrustValue * _throttle * _pressureRatio * sqrt (1 / _temperatureRatio);
_thrustValue = _thrustValue * (1 - _engineDamage) * GVAR(thrustFactor) * (sqrt _speedMax) * _massStandard * _thrustMultiplier;

if (_vtolMode > 0) then {
	GVAR(vtolThrustFactor) params ["_speedL", "_speedH", "_factorL", "_factorH"];
	_thrustValue = _thrustValue * linearConversion [_speedL, _speedH, _speedKPH / _speedMax, _factorL, _factorH, true];
};

private _thrustVector = [0, _thrustValue * cos (_thrustVector * 90), _thrustValue * sin (_thrustVector * 90)];

_thrustVector
