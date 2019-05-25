params ["_paramArray", "_dragArray", "_paramAltitude", "_isAdvanced"];
_paramArray params ["_modelvelocity", "_massCurrent", "_massError"];
_dragArray params ["_coef2", "_coef1", "_coef0"];
_paramAltitude params ["_altFullForce", "_altNoForce", "_altitude"];

// if (_massError) exitWith {[0, 0, 0]};

private _airVel = _modelvelocity vectorMultiply -1;
private _dragForceDefault = [0, 0, 0];

if (_isAdvanced) then {
	{
		_x params ["_velIndex", "_coefIndex"];
		private _velAxis = _airVel select _velIndex;
		private _force = (_coef2 select _coefIndex) * _velAxis * (abs _velAxis);
		_force = _force + (_coef1 select _coefIndex) * _velAxis;
		_force = _force + (_coef0 select _coefIndex) * ([1, -1] select (_velAxis < 0));
		_dragForceDefault set [_velIndex, _force * _massCurrent];
	} forEach [[0, 0], [1, 2], [2, 1]];
} else {
	{
		_x params ["_velIndex", "_coefIndex"];
		private _velAxis = _airVel select _velIndex;
		private _force = (_coef2 select _coefIndex) * _velAxis * (abs _velAxis);
		_force = _force + (_coef1 select _coefIndex) * _velAxis;
		_force = _force + (_coef0 select _coefIndex) * ([1, -1] select (_velAxis < 0));
		_dragForceDefault set [_velIndex, _force * _massCurrent];
	} forEach [[0, 0], [1, 2], [2, 1]];
};

_dragForceDefault = _dragForceDefault vectorMultiply linearConversion [_altFullForce, _altNoForce, _altitude, 1, 0, true];

// report if needed (dev script)
// diag_log format ["orbis_aerodynamics _dragForceDefault: %1", _dragForceDefault];

_dragForceDefault
