private _screen = _this select 0;

_screen addAction ["Update ATIS data", "_this call orbis_atc_fnc_updateATISdata;", nil, 1.1, true, true, "", "true", 5];
