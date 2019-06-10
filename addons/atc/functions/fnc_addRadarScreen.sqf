#include "script_component.hpp"

private _screen = _this select 0;

_screen addAction ["Watch ATC Radar Screen", {_this call FUNC(radarScreenOn);}, nil, 1.011, true, true, "", "!(_this getVariable ['orbis_atc_isUsingRadarScreen', false])", 5];
_screen addAction ["Stop Watching Radar Screen", {_this call FUNC(radarScreenOff);}, nil, 1.011, false, true, "", "_this getVariable ['orbis_atc_isUsingRadarScreen', false]", 5];
