params ["_paramArray", "_paramThrust", "_speedMax", "_paramAtmosphere"];
_paramArray params ["_modelvelocity", "_massStandard", "_massError", "_densityRatio"];
_paramThrust params ["_thrustCoef", "_throttle", "_thrustVector"];
_paramAtmosphere params ["_temperatureRatio", "_pressureRatio"];

// if (_massError) exitWith {[0, 0, 0]};

private _speedKPH = (_modelvelocity select 1) * 3.6;
private _thrustValue = [_thrustCoef, _speedMax, 1.5 / (count _thrustCoef - 1), _speedKPH] call orbis_aerodynamics_fnc_extractCoefArray;
_thrustValue = _thrustValue * _throttle * orbis_aerodynamics_thrustMultiplier * _pressureRatio * sqrt (1 / _temperatureRatio);
_thrustValue = _thrustValue * orbis_aerodynamics_thrustFactor * _massCurrent;

private _thrustVector = [0, _thrustValue * cos (_thrustVector * 90), _thrustValue * sin (_thrustVector * 90)];

_thrustVector
