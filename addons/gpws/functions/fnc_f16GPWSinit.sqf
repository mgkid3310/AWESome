#include "script_component.hpp"

params ["_vehicle"];

_vehicle setVariable [QGVAR(nextGPWStime), -1];
_vehicle setVariable [QGVAR(nextBeepTime), -1];
