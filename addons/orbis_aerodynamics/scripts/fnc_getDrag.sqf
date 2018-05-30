private _velocity = _this select 0;
private _dragArray = _this select 1;
private _densityRatio = _this select 2;
private _mass = _this select 3;

private _airVel = _velocity vectorMultiply -1;
private _airSpeed = sqrt (_airVel vectorDotProduct _airVel);
private _dragForce = [0, 0, 0];

for "_i" from 0 to 2 do {
    private _velAxis = _airVel select _i;
    private _force = (_dragArray select 0 select _i) * _velAxis * _airSpeed;
    _force = _force + (_dragArray select 1 select _i) * _velAxis;
    _force = _force + (_dragArray select 2 select _i) * ([1, -1] select (_velAxis < 0));
    _dragForce set [_i, _force * _densityRatio * _mass];
};

_dragForce
