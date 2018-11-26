params ["_paramArray", "_dragArray", "_liftVector", "_effectiveAngle"];
_paramArray params ["_trueAirVelocity", "_mass", "_densityRatio"];
_dragArray params ["_coef2", "_coef1", "_coef0"];

private _airVel = _trueAirVelocity vectorMultiply -1;
private _airSpeed = sqrt (_airVel vectorDotProduct _airVel);

// parasite drag (zero lift drag)
private _dragParasite = [0, 0, 0];
{
    _x params ["_velIndex", "_coefIndex"];
    private _velAxis = _airVel select _velIndex;
    private _force = (_coef2 select _coefIndex) * _velAxis * _airSpeed;
    _force = _force + (_coef1 select _coefIndex) * _velAxis;
    _force = _force + (_coef0 select _coefIndex) * ([1, -1] select (_velAxis < 0));
    _dragParasite set [_velIndex, _force * _mass * _densityRatio];
} forEach [[0, 0], [1, 2], [2, 1]];

// induced drag
_liftVector params ["_liftX", "_liftY", "_liftZ"];
private _dragInduced = [0, -_liftZ * tan deg _effectiveAngle, 0];

// sum up drags
private _dragForce = _dragParasite vectorAdd _dragInduced;

// report if needed (dev script)
// diag_log format ["orbis_aerodynamics _dragParasite: %1, _dragInduced: %2", _dragParasite, _dragInduced];

_dragForce
