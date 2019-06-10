#include "script_component.hpp"

private _screen = _this select 0;

_screen addAction ["Update ATIS data", {[true, _this select 0] call FUNC(updateATISdata);}, nil, 1.012, true, true, "", "", 5];
_screen addAction ["Listen to ATIS", {[] call FUNC(listenATISbroadcast);}, nil, 1.013, false, true, "", "_target getVariable ['orbis_atc_isATISready', true]", 10];
_screen addAction ["Stop Listening to ATIS", {(_this select 0) setVariable [QGVAR(stopATIS), true, true];}, nil, 1.013, false, true, "", "!(_target getVariable ['orbis_atc_stopATIS', true])", 10];
