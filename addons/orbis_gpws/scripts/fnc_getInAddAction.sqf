params ["_unit", "_position", "_vehicle", "_turret"];

private _hasAction = _vehicle getVariable ["orbis_gpws_hasAction", false];
if (_hasAction || !(_vehicle isKindOf "Plane")) exitWith {};

_vehicle addAction ["Turn off GPWS", "(_this select 0) setVariable ['orbisGPWSmode', '']", nil, 1, false, true, "", "(_this isEqualTo driver _target) && (_target getVariable ['orbisGPWSenabled', false]) && (_target getVariable ['orbisGPWSmode', ''] != '')", 10];
_vehicle addAction ["Set to Betty (F-16)", "[_this select 0] spawn orbis_gpws_fnc_f16GPWS", nil, 1, false, true, "", "(_this isEqualTo driver _target) && (_target getVariable ['orbisGPWSenabled', false]) && (_target getVariable ['orbisGPWSmode', ''] != 'f16')", 10];
_vehicle addAction ["Test GPWS (Betty)", "[_this select 0] spawn orbis_gpws_fnc_f16GPWStest", nil, 1, false, true, "", "(_this isEqualTo driver _target) && (_target getVariable ['orbisGPWSenabled', false]) && (_target getVariable ['orbisGPWSmode', ''] == 'f16')", 10];
// _vehicle addAction ["Set to B747 GPWS", "[_this select 0] spawn orbis_gpws_fnc_b747GPWS", nil, 1, false, true, "", "(_this isEqualTo driver _target) && (_target getVariable ['orbisGPWSenabled', false]) && (_target getVariable ['orbisGPWSmode', ''] != 'b747')", 10];
_vehicle setVariable ["orbis_gpws_hasAction", true];
