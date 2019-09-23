#include "script_component.hpp"

params ["_posASL", ["_dynamicWindMode", GVAR(dynamicWindMode)]];

if !(_dynamicWindMode > 0) exitWith {wind};

if !(_posASL isEqualType []) then {
	_posASL = getPosASL _posASL;
};

wind
