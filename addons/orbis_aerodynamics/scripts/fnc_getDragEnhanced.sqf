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

// induced drag (incl. lift-dependent parasite & wave drag)
private _inducedConst = (2 * 1.2754) / (_densityRatio * pi * 0.5 * 400);
private _inducedValue = ((vectorMagnitude _liftVector) / (_airSpeed max (_speedStall / 3.6))) ^ 2;
private _dragInduced = (vectorNormalized _airVel) vectorMultiply (_inducedConst * _inducedValue * (orbis_aerodynamics_dragMultiplier select 1));

// wave drag (zero lift drag)
private _dragWave = [0, 0, 0];

// sum up drags
private _dragForceEnhanced = _dragParasite vectorAdd _dragInduced vectorAdd _dragWave;

// report if needed (dev script)
// diag_log format ["orbis_aerodynamics _dragParasite: %1, _dragInduced: %2, _dragForceEnhanced: %3", _dragParasite, _dragInduced, _dragForceEnhanced];
// diag_log format ["orbis_aerodynamics SPD: %1, Base: %2, Parasite: %3, Induced: %4, Total: %5", _airSpeed * 3.6, vectorMagnitude _dragParasite, vectorMagnitude _dragInduced, vectorMagnitude _dragForceEnhanced];

_dragForceEnhanced
