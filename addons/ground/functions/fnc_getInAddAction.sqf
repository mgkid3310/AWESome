#include "script_component.hpp"

params ["_unit", "_position", "_vehicle", "_turret"];

private _hasAction = _vehicle getVariable [QGVAR(hasAction), false];
if (_hasAction) exitWith {};

if (_vehicle isKindOf "Offroad_01_base_F") then {
	_vehicle addAction [localize LSTRING(deployTowBar), {[_this select 0] call FUNC(deployTowBar)}, nil, 1, false, true, "", "(_this isEqualTo driver _target) && !(_target getVariable ['orbis_ground_hasTowBarDeployed', false]) && (speed _target < 1)", 10];
	_vehicle addAction [localize LSTRING(removeTowBar), {[_this select 0] call FUNC(removeTowBar)}, nil, 1, false, true, "", "(_this isEqualTo driver _target) && (_target getVariable ['orbis_ground_hasTowBarDeployed', true]) && (speed _target < 1)", 10];
};
/* if (_vehicle isKindOf "Plane") then {
	_vehicle addAction ["Set Parking Brake", {[_this select 0] call FUNC(parkingBrakeSet)}, nil, 1, false, true, "", "([_this, _target, 1] call orbis_main_fnc_isCrew) && !(_target getVariable ['orbis_ground_parkingBrakeSet', false]) && (speed _target < 1)", 10];
	_vehicle addAction ["Release Parking Brake", {[_this select 0] call FUNC(parkingBrakeRelease)}, nil, 1, false, true, "", "([_this, _target, 1] call orbis_main_fnc_isCrew) && (_target getVariable ['orbis_ground_parkingBrakeSet', true])", 10];
}; */

_vehicle setVariable [QGVAR(hasAction), true];
