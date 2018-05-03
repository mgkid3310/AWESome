// _this addAction ["Watch ATC Radar Screen", "_this call orbis_atc_fnc_radarScreenOn;", nil, 1, true, true, "", "!(_this getVariable ['isUsingRadarScreen', false])", 5];
// _this addAction ["Stop Watching Radar Screen", "player setVariable ['isUsingRadarScreen', false, true];", nil, 1, false, true, "", "(_this getVariable ['isUsingRadarScreen', false])", 5];

orbis_atc_fnc_atcRadarLoop = compile preProcessFileLineNumbers "orbis_atc_environment\scripts\fnc_atcRadarLoop.sqf";
orbis_atc_fnc_createMarkers = compile preProcessFileLineNumbers "orbis_atc_environment\scripts\fnc_createMarkers.sqf";
orbis_atc_fnc_radarScreenOn = compile preProcessFileLineNumbers "orbis_atc_environment\scripts\fnc_radarScreenOn.sqf";
orbis_atc_fnc_updateMarkerSpacing = compile preProcessFileLineNumbers "orbis_atc_environment\scripts\fnc_updateMarkerSpacing.sqf";
