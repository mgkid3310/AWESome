#include "script_component.hpp"

params ["_unit", "_position", "_vehicle", "_turret"];

private _hasAction = _vehicle getVariable [QGVAR(hasAction), false];
if (_hasAction || (!(_vehicle isKindOf "Plane") && !(_vehicle isKindOf "Helicopter"))) exitWith {};

_vehicle addAction ["Listen to ATIS", {[] call FUNC(listenATISbroadcast)}, nil, 1.0141, false, true, "", "([nil, _target] call orbis_main_isCrew) && (_target getVariable ['orbis_atc_isATISready', true])", 10];
_vehicle addAction ["Stop Listening to ATIS", {(_this select 0) setVariable [QGVAR(stopATIS), true, true]}, nil, 1.0142, false, true, "", "([nil, _target] call orbis_main_isCrew) && !(_target getVariable ['orbis_atc_fnc_stopATIS', true])", 10];

_vehicle setVariable [QGVAR(hasAction), true];
