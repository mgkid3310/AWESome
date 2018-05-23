params ["_unit", "_position", "_vehicle", "_turret"];

private _hasAction = _vehicle getVariable ["orbis_atc_hasAction", false];
if (_hasAction || (!(_vehicle isKindOf "Plane") && !(_vehicle isKindOf "Helicopter"))) exitWith {};

_vehicle addAction ["Listen to ATIS", "[] call orbis_atc_fnc_listenATISbroadcast", nil, 1, false, true, "", "(_this isEqualTo driver _target) && (_target getVariable ['orbisATISready', true])", 10];
_vehicle setVariable ["orbis_atc_hasAction", true];
