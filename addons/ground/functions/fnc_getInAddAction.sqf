#include "script_component.hpp"

params ["_unit", "_position", "_vehicle", "_turret"];

private _hasAction = _vehicle getVariable [QGVAR(hasAction), false];
if (_hasAction) exitWith {};

if (_vehicle isKindOf "Offroad_01_base_F") then {
	_vehicle addAction ["Deploy Towbar", QUOTE([_this select 0] call FUNC(deployTowBar)), nil, 1, false, true, "", QUOTE((isClass (configFile >> 'CfgPatches' >> 'orbis_ground')) && (_this isEqualTo driver _target) && !(_target getVariable ['orbis_hasTowBarDeployed', false]) && (speed _target < 1)), 10];
	_vehicle addAction ["Remove Towbar", QUOTE([_this select 0] call FUNC(removeTowBar)), nil, 1, false, true, "", QUOTE((isClass (configFile >> 'CfgPatches' >> 'orbis_ground')) && (_this isEqualTo driver _target) && (_target getVariable ['orbis_hasTowBarDeployed', true]) && (speed _target < 1)), 10];
};
/* if (_vehicle isKindOf "Plane") then {
	_vehicle addAction ["Set Parking Brake", QUOTE([_this select 0] call FUNC(parkingBrakeSet)), nil, 1, false, true, "", QUOTE((isClass (configFile >> 'CfgPatches' >> 'orbis_ground')) && ([nil, nil, 1] call EFUNC(main,isCrew)) && !(_target getVariable ['orbis_parkingBrakeSet', false]) && (speed _target < 1)), 10];
	_vehicle addAction ["Release Parking Brake", QUOTE([_this select 0] call FUNC(parkingBrakeRelease)), nil, 1, false, true, "", QUOTE((isClass (configFile >> 'CfgPatches' >> 'orbis_ground')) && ([nil, nil, 1] call EFUNC(main,isCrew)) && (_target getVariable ['orbis_parkingBrakeSet', true])), 10];
}; */
_vehicle setVariable [QGVAR(hasAction), true, true];
