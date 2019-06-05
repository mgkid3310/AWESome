#include "script_component.hpp"

private _screen = _this select 0;

_screen addAction ["Watch ATC Radar Screen", "_this call FUNC(radarScreenOn);", nil, 1.011, true, true, "", "(isClass (configFile >> 'CfgPatches' >> 'GVAR(environment)')) && !(_this getVariable ['GVAR(isUsingRadarScreen)', false])", 5];
_screen addAction ["Stop Watching Radar Screen", "_this call FUNC(radarScreenOff);", nil, 1.011, false, true, "", "(isClass (configFile >> 'CfgPatches' >> 'GVAR(environment)')) && (_this getVariable ['GVAR(isUsingRadarScreen)', false])", 5];
