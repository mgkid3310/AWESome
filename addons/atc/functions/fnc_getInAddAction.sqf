#include "script_component.hpp"

params ["_unit", "_position", "_vehicle", "_turret"];

private _hasAction = _vehicle getVariable [QGVAR(hasAction), false];
if (_hasAction || (!(_vehicle isKindOf "Plane") && !(_vehicle isKindOf "Helicopter"))) exitWith {};

_vehicle addAction ["Listen to ATIS", QUOTE([] call FUNC(listenATISbroadcast)), nil, 1.0141, false, true, "", QUOTE(([nil, _target] call EFUNC(main,isCrew)) && (_target getVariable [QGVAR(isATISready), true])), 10];
_vehicle addAction ["Stop Listening to ATIS", QUOTE((_this select 0) setVariable [QGVAR(stopATIS), true, true]), nil, 1.0142, false, true, "", QUOTE(([nil, _target] call EFUNC(main,isCrew)) && !(_target getVariable [QGVAR(stopATIS), true])), 10];

_vehicle setVariable [QGVAR(hasAction), true, true];
