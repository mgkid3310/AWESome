params ["_unit", "_position", "_vehicle", "_turret"];

private _hasAction = _vehicle getVariable ["awesome_ground_hasAction", false];
if (_hasAction) exitWith {};

if (_vehicle isKindOf "Offroad_01_base_F") then {
    _vehicle addAction ["Deploy Towbar", "[_this select 0] call awesome_ground_fnc_deployTowBar", nil, 1, false, true, "", "(isClass (configFile >> 'CfgPatches' >> 'awesome_ground')) && (_this isEqualTo driver _target) && !(_target getVariable ['awesome_hasTowBarDeployed', false]) && (speed _target < 1)", 10];
    _vehicle addAction ["Remove Towbar", "[_this select 0] call awesome_ground_fnc_removeTowBar", nil, 1, false, true, "", "(isClass (configFile >> 'CfgPatches' >> 'awesome_ground')) && (_this isEqualTo driver _target) && (_target getVariable ['awesome_hasTowBarDeployed', true]) && (speed _target < 1)", 10];
};
/* if (_vehicle isKindOf "Plane") then {
    _vehicle addAction ["Set Parking Brake", "[_this select 0] call awesome_ground_fnc_parkingBrakeSet", nil, 1, false, true, "", "(isClass (configFile >> 'CfgPatches' >> 'awesome_ground')) && ([nil, nil, 1] call awesome_awesome_fnc_isCrew) && !(_target getVariable ['awesome_parkingBrakeSet', false]) && (speed _target < 1)", 10];
    _vehicle addAction ["Release Parking Brake", "[_this select 0] call awesome_ground_fnc_parkingBrakeRelease", nil, 1, false, true, "", "(isClass (configFile >> 'CfgPatches' >> 'awesome_ground')) && ([nil, nil, 1] call awesome_awesome_fnc_isCrew) && (_target getVariable ['awesome_parkingBrakeSet', true])", 10];
}; */
_vehicle setVariable ["awesome_ground_hasAction", true, true];
