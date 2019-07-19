#include "script_component.hpp"

if (player getVariable [QGVAR(isUsingRadar), false]) exitWith {};

player setVariable [QGVAR(isUsingRadar), true];
player setVariable [QGVAR(radarParam), _this];
