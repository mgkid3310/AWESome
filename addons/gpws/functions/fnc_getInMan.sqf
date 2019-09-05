#include "script_component.hpp"
#include "header_macros.hpp"

params ["_unit", "_role", "_vehicle", "_turret"];
DEV_CHAT("orbis_gpws: getInMan run");

if !([_unit, _vehicle, 1] call EFUNC(main,isCrew)) exitWith {};

// check if has GPWS enabled
private _isGPWSenabled = _vehicle getVariable [QGVAR(isGPWSenabled), 0];
private _enable = true;
if (_isGPWSenabled isEqualType true) then {
	if !(_isGPWSenabled) then {
		_enable = false;
	};
} else {
	if !(getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> QGVAR(isGPWSenabled)) > 0) then {
		_enable = false;
	};
};

if !(_enable) exitWith {
	_vehicle setVariable [QGVAR(isGPWSenabled), false, true];
};
_vehicle setVariable [QGVAR(isGPWSenabled), true, true];

// GPWS initialization
private _modeCurrent = _vehicle getVariable [QGVAR(GPWSmode), "init"];
if (_modeCurrent isEqualTo "init") then {
	_vehicle setVariable [QGVAR(GPWSvolumeLow), GVAR(defaultVolumeLow), true];

	if !(GVAR(personalDefault) isEqualTo "none") exitWith {
		_vehicle setVariable [QGVAR(GPWSmode), GVAR(personalDefault), true];
	};

	if (getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> QGVAR(defaultGPWS)) isEqualTo "f16") exitWith {
		_vehicle setVariable [QGVAR(GPWSmode), "f16", true];
	};

	_vehicle setVariable [QGVAR(GPWSmode), "off", true];
};
