#include "script_component.hpp"

params [["_array", []]];

private _return = _array;
private ["_vehicle", "_crews"];
{
	_vehicle = _x;
	_crews = (crew _x) select {isPlayer _x};
	_crews = _crews select {[_x, _vehicle, 0] call EFUNC(main,isCrew)};
	{
		if (missionNamespace getVariable [QEGVAR(gpws,hasAWESomeGPWS) + getPlayerUID _x, false]) exitWith {
			_return = _return - [_vehicle];
		};
	} forEach _crews;
} forEach _array;

_return
