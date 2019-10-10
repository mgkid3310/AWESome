#include "script_component.hpp"

if (player getVariable [QGVAR(isUsingRadar), false]) exitWith {};

params ["_monitor", "_controller", ["_radarMode", 0]];

player setVariable [QGVAR(isUsingRadar), true];
player setVariable [QGVAR(radarParam), [_monitor, _controller, _radarMode]];
