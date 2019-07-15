#include "script_component.hpp"

if !(player getVariable [QGVAR(isUsingRadar), false]) exitWith {};

player setVariable [QGVAR(exitRadar), true];
