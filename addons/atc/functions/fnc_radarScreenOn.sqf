#include "script_component.hpp"

if (player getVariable [QGVAR(isUsingRadarScreen), false]) exitWith {};

player setVariable [QGVAR(startRadarScreen), _this, true];
