private _screen = _this select 0;

_screen addAction ["Watch ATC Radar Screen", "_this call orbis_atc_fnc_radarScreenOn;", nil, 1, true, true, "", "!(_this getVariable ['isUsingRadarScreen', false])", 5];
_screen addAction ["Stop Watching Radar Screen", "player setVariable ['isUsingRadarScreen', false, true];", nil, 1, false, true, "", "(_this getVariable ['isUsingRadarScreen', false])", 5];
