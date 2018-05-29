params ["_unit", "_position", "_vehicle", "_turret"];

private _hasAction = _vehicle getVariable ["orbis_gpws_hasAction", false];
if (_hasAction || !(_vehicle isKindOf "Plane")) exitWith {};

_vehicle addAction ["Turn off GPWS", "(_this select 0) setVariable ['orbisGPWSmode', '', true]", nil, 1, false, true, "", "(isClass (configFile >> 'CfgPatches' >> 'orbis_gpws')) && (_this in [driver _target, gunner _target, commander _target]) && (_target getVariable ['orbisGPWSenabled', false]) && (_target getVariable ['orbisGPWSmode', ''] != '')", 10];
_vehicle addAction ["Set to Betty (F-16)", "['orbisStartGPWS', [_target, 'f16']] call CBA_fnc_globalEvent", nil, 1, false, true, "", "(isClass (configFile >> 'CfgPatches' >> 'orbis_gpws')) && (_this in [driver _target, gunner _target, commander _target]) && (_target getVariable ['orbisGPWSenabled', false]) && (_target getVariable ['orbisGPWSmode', ''] != 'f16')", 10];
_vehicle addAction ["Test GPWS (Betty)", "[_this select 0] spawn orbis_gpws_fnc_f16GPWStest", nil, 1, false, true, "", "(isClass (configFile >> 'CfgPatches' >> 'orbis_gpws')) && (_this in [driver _target, gunner _target, commander _target]) && (_target getVariable ['orbisGPWSenabled', false]) && (_target getVariable ['orbisGPWSmode', ''] == 'f16') && (_target getVariable ['orbisGPWStestReady', true])", 10];
_vehicle addAction ["Set to B747 GPWS", "['orbisStartGPWS', [_target, 'b747']] call CBA_fnc_globalEvent", nil, 1, false, true, "", "(isClass (configFile >> 'CfgPatches' >> 'orbis_gpws')) && (_this in [driver _target, gunner _target, commander _target]) && (_target getVariable ['orbisGPWSenabled', false]) && (_target getVariable ['orbisGPWSmode', ''] != 'b747')", 10];
_vehicle addAction ["Test GPWS (B747)", "[_this select 0] spawn orbis_gpws_fnc_b747GPWStest", nil, 1, false, true, "", "(isClass (configFile >> 'CfgPatches' >> 'orbis_gpws')) && (_this in [driver _target, gunner _target, commander _target]) && (_target getVariable ['orbisGPWSenabled', false]) && (_target getVariable ['orbisGPWSmode', ''] == 'b747') && (_target getVariable ['orbisGPWStestReady', true])", 10];
_vehicle setVariable ["orbis_gpws_hasAction", true, true];
