params ["_paramArray", "_paramThrust", "_speedMax", "_paramAltitude"];
_paramArray params ["_modelvelocity", "_massCurrent", "_massError"];
_paramThrust params ["_thrustCoef", "_throttle"];
_paramAltitude params ["_altFullForce", "_altNoForce", "_altitude"];

// if (_massError) exitWith {[0, 0, 0]};

private _speedKPH = (_modelvelocity select 1) * 3.6;
private _thrustValue = [_thrustCoef, _speedMax, 1.5 / (count _thrustCoef - 1), _speedKPH] call orbis_aerodynamics_fnc_extractCoefArray;
_thrustValue = _thrustValue * _throttle * linearConversion [_altFullForce, _altNoForce, _altitude, 1, 0, true];

private _thrustVector = [0, _thrustValue * orbis_aerodynamics_thrustFactor * _massCurrent, 0];

_thrustVector
