private _screen = _this select 0;

_screen addAction ["Update ATIS data", "[true, _this select 0] call orbis_atc_fnc_updateATISdata;", nil, 1.1, true, true, "", "isClass (configFile >> 'CfgPatches' >> 'orbis_atc_environment')", 5];
