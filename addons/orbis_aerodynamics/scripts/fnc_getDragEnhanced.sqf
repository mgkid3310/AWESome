params ["_paramArray", "_dragArray", "_liftVector", "_speedStall"];
_paramArray params ["_trueAirVelocity", "_mass", "_densityRatio"];
_dragArray params ["_coef2", "_coef1", "_coef0"];

private _airVel = _trueAirVelocity vectorMultiply -1;
private _airSpeed = vectorMagnitude _airVel;

// parasite drag (zero lift drag)
private _dragParasite = [0, 0, 0];
{
    _x params ["_velIndex", "_coefIndex"];
    private _velAxis = _airVel select _velIndex;
    private _force = (_coef2 select _coefIndex) * _velAxis * _airSpeed;
    _force = _force + (_coef1 select _coefIndex) * _velAxis;
    _force = _force + (_coef0 select _coefIndex) * ([1, -1] select (_velAxis < 0));
    _dragParasite set [_velIndex, _force * _mass * _densityRatio * (orbis_aerodynamics_dragMultiplier select 0)];
} forEach [[0, 0], [1, 2], [2, 1]];

// induced drag (including lift-dependent parasite & wave drag)
private _inducedConst = (2 * 1.2754) / (_densityRatio * pi * 0.5 * 400);
private _inducedValue = ((vectorMagnitude _liftVector) / (_airSpeed max (_speedStall / 3.6))) ^ 2;
private _dragInduced = (vectorNormalized _airVel) vectorMultiply (_inducedConst * _inducedValue * (orbis_aerodynamics_dragMultiplier select 1));

// wave drag (zero lift drag)
orbis_aerodynamics_waveCdArray params ["_machCritical", "_transStart", "_machMaxCd", "_transEnd", "_multiplierMax", "_roundFwd", "_roundAft", "_machPower"];
private _machNumber = _airSpeed / sqrt (103497 / _densityRatio);
private _waveCdMultiplier = 0;
switch (true) do {
    case (_machNumber < _transStart): {
        _waveCdMultiplier = ((_multiplierMax - _roundFwd) / ((_transStart - _machCritical) ^ 4)) * (((_machCritical max _machNumber min _transStart) - _machCritical) ^ 4);
    };
    case (_machNumber < _machMaxCd): {
        private _slope = 4 * (_multiplierMax - _roundFwd) / (_transStart - _machCritical);
        private _power = _slope * (_machMaxCd - _transStart) / _roundFwd;
        _waveCdMultiplier = _multiplierMax - (_roundFwd / ((_machMaxCd - _transStart) ^ _power)) * ((_machMaxCd - _machNumber) ^ _power);
    };
    case (_machNumber == _machMaxCd): {
        _waveCdMultiplier = _multiplierMax;
    };
    case (_machNumber < _transEnd): {
        private _slope = _machPower * (_multiplierMax - _roundAft) / _transEnd;
        private _power = -_slope * (_transEnd - _machMaxCd) / _roundAft;
        _waveCdMultiplier = _multiplierMax - (_roundAft / ((_transEnd - _machMaxCd) ^ _power)) * ((_machNumber - _machMaxCd) ^ _power);
    };
    default {
        _waveCdMultiplier = (_multiplierMax - _roundAft) * (_machNumber ^ _machPower) / (_transEnd ^ _machPower);
    };
};
private _waveCoef = _coef2 vectorMultiply _waveCdMultiplier;
private _dragWave = [0, 0, 0];
{
    _x params ["_velIndex", "_coefIndex"];
    private _velAxis = _airVel select _velIndex;
    private _force = (_waveCoef select _coefIndex) * _velAxis * _airSpeed;
    _dragWave set [_velIndex, _force * _mass * _densityRatio * (orbis_aerodynamics_dragMultiplier select 2)];
} forEach [[0, 0], [1, 2], [2, 1]];

// sum up drags
private _dragForceEnhanced = _dragParasite vectorAdd _dragInduced vectorAdd _dragWave;

// report if needed (dev script)
// diag_log format ["orbis_aerodynamics _dragParasite: %1, _dragInduced: %2, _dragForceEnhanced: %3", _dragParasite, _dragInduced, _dragForceEnhanced];
if (AWESOME_DEVMODE_LOG) then {
    diag_log format ["orbis_aerodynamics Mach: %1, Base: %2, Parasite: %3, Induced: %4, Wave: %5, Total: %6", _machNumber, vectorMagnitude _dragParasite / (orbis_aerodynamics_dragMultiplier select 0), vectorMagnitude _dragParasite, vectorMagnitude _dragInduced, vectorMagnitude _dragWave, vectorMagnitude _dragForceEnhanced];
};

_dragForceEnhanced
