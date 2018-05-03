private _dragArray = _this select 0;
private _velocity = _this select 1;

private _dragForce = [0, 0, 0];

for "_index" from 0 to 2 do {
    private _velAxis = _velocity select _i;
    private _force = (_dragArray select 0 select _i) * _velAxis * (abs _velAxis);
    _force = _force + (_dragArray select 1 select _i) * _velAxis;
    _force = _force + (_dragArray select 2 select _i) * _velAxis / (abs _velAxis);
    _dragForce set [_i, _force];
};

_dragForce
