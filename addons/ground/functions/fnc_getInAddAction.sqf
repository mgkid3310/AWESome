#include "script_component.hpp"

params ["_unit", "_position", "_vehicle", "_turret"];

private _hasAction = _vehicle getVariable [QGVAR(hasAction), false];
if (_hasAction) exitWith {};

if (_vehicle isKindOf "Offroad_01_base_F") then {
	_vehicle addAction ["Deploy Towbar", QUOTE([_this select 0] call FUNC(deployTowBar)), nil, 1, false, true, "", QUOTE((_this isEqualTo driver _target) && !(_target getVariable [QGVAR(hasTowBarDeployed), false]) && (speed _target < 1)), 10];
	_vehicle addAction ["Remove Towbar", QUOTE([_this select 0] call FUNC(removeTowBar)), nil, 1, false, true, "", QUOTE((_this isEqualTo driver _target) && (_target getVariable [QGVAR(hasTowBarDeployed), true]) && (speed _target < 1)), 10];
};
/* if (_vehicle isKindOf "Plane") then {
	_vehicle addAction ["Set Parking Brake", QUOTE([_this select 0] call FUNC(parkingBrakeSet)), nil, 1, false, true, "", QUOTE(([nil, nil, 1] call EFUNC(main,isCrew)) && !(_target getVariable [QGVAR(parkingBrakeSet), false]) && (speed _target < 1)), 10];
	_vehicle addAction ["Release Parking Brake", QUOTE([_this select 0] call FUNC(parkingBrakeRelease)), nil, 1, false, true, "", QUOTE(([nil, nil, 1] call EFUNC(main,isCrew)) && (_target getVariable [QGVAR(parkingBrakeSet), true])), 10];
}; */

_vehicle setVariable [QGVAR(hasAction), true, true];
