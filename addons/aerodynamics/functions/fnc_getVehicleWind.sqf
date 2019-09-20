#include "script_component.hpp"

params ["_posASL", ["_dynamicWindEnabled", GVAR(dynamicWindEnabled)]];

if !(_dynamicWindEnabled) exitWith {wind};

if !(_posASL isEqualType []) then {
	_posASL = getPosASL _posASL;
};

wind
