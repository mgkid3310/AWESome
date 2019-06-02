private _array = _this param [0, []];
_array = _array select {isEngineOn _x};

private _return = _array;
private ["_vehicle", "_crews"];
{
	_vehicle = _x;
	_crews = (crew _x) select {[_x, _vehicle, 0] call orbis_awesome_fnc_isCrew};
	{
		if (_x getVariable ["orbis_gpws_hasGPWS", false]) exitWith {
			_return = _return - [_vehicle];
		};
	} forEach _crews;
} forEach _array;

_return
