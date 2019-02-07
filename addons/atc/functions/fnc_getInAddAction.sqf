params ["_unit", "_position", "_vehicle", "_turret"];

private _hasAction = _vehicle getVariable ["awesome_atc_hasAction", false];
if (_hasAction || (!(_vehicle isKindOf "Plane") && !(_vehicle isKindOf "Helicopter"))) exitWith {};

_vehicle addAction ["Listen to ATIS", "[] call awesome_atc_fnc_listenATISbroadcast", nil, 1, false, true, "", "(isClass (configFile >> 'CfgPatches' >> 'awesome_atc_environment')) && ([] call awesome_awesome_fnc_isCrew) && (_target getVariable ['orbisATISready', true])", 10];
_vehicle addAction ["Stop Listening to ATIS", "(_this select 0) setVariable ['orbisATISstop', true, true]", nil, 1, false, true, "", "(isClass (configFile >> 'CfgPatches' >> 'awesome_atc_environment')) && ([] call awesome_awesome_fnc_isCrew) && !(_target getVariable ['orbisATISstop', true])", 10];
_vehicle setVariable ["awesome_atc_hasAction", true, true];
