private _screen = _this select 0;

_screen addAction ["Watch ATC Radar Screen", "_this call orbis_atc_fnc_radarScreenOn;", nil, 1.011, true, true, "", "(isClass (configFile >> 'CfgPatches' >> 'orbis_atc_environment')) && !(_this getVariable ['orbis_atc_isUsingRadarScreen', false])", 5];
_screen addAction ["Stop Watching Radar Screen", "_this call orbis_atc_fnc_radarScreenOff;", nil, 1.011, false, true, "", "(isClass (configFile >> 'CfgPatches' >> 'orbis_atc_environment')) && (_this getVariable ['orbis_atc_isUsingRadarScreen', false])", 5];
