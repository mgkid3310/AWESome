params ["_paramArray", "_torqueXCoef"];
_paramArray params ["_velocity", "_mass", "_densityRatio"];

private _airVel = _velocity vectorMultiply -1;
private _airSpeed = sqrt (_airVel vectorDotProduct _airVel);
private _torqueForce = [0, 0, 0];

/* for "_i" from 0 to 2 do {
	private _velAxis = _airVel select _i;
	private _force = (_dragArray select 0 select _i) * _velAxis * _airSpeed;
	_force = _force + (_dragArray select 1 select _i) * _velAxis;
	_force = _force + (_dragArray select 2 select _i) * ([1, -1] select (_velAxis < 0));
	_torqueForce set [_i, _force * _mass * _densityRatio];
}; */

_torqueForce
