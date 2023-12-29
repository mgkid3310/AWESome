#include "script_component.hpp"

params ["_vehicle", "_side"];

private _hostileTo = _vehicle getVariable [QGVAR(isHostileTo), []];
if (_side in _hostileTo) then {
	_hostileTo = _hostileTo - [_side];
} else {
	_hostileTo pushBackUnique _side;
};

_vehicle setVariable [QGVAR(isHostileTo), _hostileTo, true];
