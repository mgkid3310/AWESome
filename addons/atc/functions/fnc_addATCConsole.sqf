private _screen = _this select 0;

_screen addAction ["Update ATIS data", "[true, _this select 0] call awesome_atc_fnc_updateATISdata;", nil, 1.1, true, true, "", "isClass (configFile >> 'CfgPatches' >> 'awesome_atc_environment')", 5];
_vehicle addAction ["Listen to ATIS", "[] call awesome_atc_fnc_listenATISbroadcast", nil, 1, false, true, "", "(isClass (configFile >> 'CfgPatches' >> 'awesome_atc_environment')) && (_this isEqualTo driver _target) && (_target getVariable ['orbisATISready', true])", 10];
