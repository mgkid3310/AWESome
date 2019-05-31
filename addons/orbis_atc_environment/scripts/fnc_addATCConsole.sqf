private _screen = _this select 0;

_screen addAction ["Update ATIS data", "[true, _this select 0] call orbis_atc_fnc_updateATISdata;", nil, 1.1, true, true, "", "", 5];
_screen addAction ["Listen to ATIS", "[] call orbis_atc_fnc_listenATISbroadcast", nil, 1, false, true, "", "(_target getVariable ['orbisATISready', true])", 10];
_screen addAction ["Stop Listening to ATIS", "(_this select 0) setVariable ['orbisATISstop', true, true]", nil, 1, false, true, "", "!(_target getVariable ['orbisATISstop', true])", 10];
