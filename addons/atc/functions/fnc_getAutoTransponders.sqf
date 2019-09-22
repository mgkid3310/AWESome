#include "script_component.hpp"

params [["_array", []]];

private _return = _array;
private ["_vehicle", "_crews"];
{
	_vehicle = _x;
	_crews = (crew _x) select {[_x, _vehicle, 0] call EFUNC(main,isCrew)};
	{
		if (_x getVariable [QEGVAR(gpws,hasAWESomeGPWS), false]) exitWith {
			_return = _return - [_vehicle];
		};
	} forEach _crews;
} forEach _array;

_return
