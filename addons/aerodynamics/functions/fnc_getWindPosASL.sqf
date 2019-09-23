#include "script_component.hpp"

params ["_posASL", ["_dynamicWindMode", GVAR(dynamicWindMode)]];

if !(_dynamicWindMode > 0) exitWith {wind};

wind
