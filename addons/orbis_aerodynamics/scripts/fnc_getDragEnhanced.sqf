params ["_paramArray", "_dragArray"];
_paramArray params ["_trueAirVelocity", "_mass", "_densityRatio"];
_dragArray params ["_coef2", "_coef1", "_coef0"];

private _airVel = _trueAirVelocity vectorMultiply -1;
private _airSpeed = sqrt (_airVel vectorDotProduct _airVel);
private _dragForce = [0, 0, 0];

{
    _x params ["_velIndex", "_coefIndex"];
    private _velAxis = _airVel select _velIndex;
    private _force = (_coef2 select _coefIndex) * _velAxis * _airSpeed;
    _force = _force + (_coef1 select _coefIndex) * _velAxis;
    _force = _force + (_coef0 select _coefIndex) * ([1, -1] select (_velAxis < 0));
    _dragForce set [_velIndex, _force * _mass * _densityRatio];
} forEach [[0, 0], [1, 2], [2, 1]];

_dragForce
