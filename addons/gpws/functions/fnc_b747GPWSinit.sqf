#include "script_component.hpp"

params ["_vehicle"];

_vehicle setVariable [QGVAR(nextGPWStime), -1];
_vehicle setVariable [QGVAR(nextBeepTime), -1];
_vehicle setVariable [QGVAR(minWarnLevel), 0];
_vehicle setVariable [QGVAR(altInformLevel), 2000];
