params ["_unit", "_position", "_vehicle", "_turret"];

private _hasAction = _vehicle getVariable ["orbis_ground_hasAction", false];
if (_hasAction) exitWith {};

if (_vehicle isKindOf "Offroad_01_repair_base_F") then {
    _vehicle addAction ["Deploy Towbar", "[_this select 0] call orbis_ground_fnc_deployTowBar", nil, 1, false, true, "", "(_this isEqualTo driver _target) && !(_target getVariable ['orbis_hasTowBarDeployed', false]) && (speed _target < 1)", 10];
    _vehicle addAction ["Remove Towbar", "[_this select 0] call orbis_ground_fnc_removeTowBar", nil, 1, false, true, "", "(_this isEqualTo driver _target) && (_target getVariable ['orbis_hasTowBarDeployed', true]) && (speed _target < 1)", 10];
};
if (_vehicle isKindOf "Plane") then {
    _vehicle addAction ["Set Parking Brake", "[_this select 0] call orbis_ground_fnc_parkingBrakeSet", nil, 1, false, true, "", "(_this isEqualTo driver _target) && !(_target getVariable ['orbis_parkingBrakeSet', false]) && (speed _target < 1)", 10];
    _vehicle addAction ["Release Parking Brake", "[_this select 0] call orbis_ground_fnc_parkingBrakeRelease", nil, 1, false, true, "", "(_this isEqualTo driver _target) && (_target getVariable ['orbis_parkingBrakeSet', true])", 10];
};
_vehicle setVariable ["orbis_ground_hasAction", true];
