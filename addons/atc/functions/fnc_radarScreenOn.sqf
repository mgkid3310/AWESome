#include "script_component.hpp"

if (player getVariable [QGVAR(isUsingRadar), false]) exitWith {};

player setVariable [QGVAR(startRadarScreen), _this];
