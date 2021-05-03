#include "script_component.hpp"

if (player getVariable [QGVAR(isUsingRadar), false]) exitWith {};

params ["_monitor", "_controller", ["_settings", [0, 10]]];
_settings params [["_radarMode", 0], ["_distance", 10]];

player setVariable [QGVAR(isUsingRadar), true];
player setVariable [QGVAR(radarParam), [_monitor, _controller, _radarMode, _distance]];
