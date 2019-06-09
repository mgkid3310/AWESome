#include "script_component.hpp"

private _screen = _this select 0;

_screen addAction ["Watch ATC Radar Screen", QUOTE(_this call FUNC(radarScreenOn);), nil, 1.011, true, true, "", QUOTE((isClass (configFile >> 'CfgPatches' >> QGVAR(environment))) && !(_this getVariable [QGVAR(isUsingRadarScreen), false])), 5];
_screen addAction ["Stop Watching Radar Screen", QUOTE(_this call FUNC(radarScreenOff);), nil, 1.011, false, true, "", QUOTE((isClass (configFile >> 'CfgPatches' >> QGVAR(environment))) && (_this getVariable [QGVAR(isUsingRadarScreen), false])), 5];
