#include "script_component.hpp"
#include "header_macros.hpp"

params ["_unit", "_role", "_vehicle", "_turret"];

DEV_CHAT("orbis_gpws: getInMan run");

if !([_unit, _vehicle, 1] call EFUNC(main,isCrew)) exitWith {};

// check if has GPWS enabled
private _GPWSenabled = _vehicle getVariable [QGVAR(GPWSenabled), 0];
private _enable = true;
if (_GPWSenabled isEqualType true) then {
	if !(_GPWSenabled) then {
		_enable = false;
	};
} else {
	if !(getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> QGVAR(GPWSenabled)) > 0) then {
		_enable = false;
	};
};

if !(_enable) exitWith {
	_vehicle setVariable [QGVAR(GPWSenabled), false, true];
};
_vehicle setVariable [QGVAR(GPWSenabled), true, true];

// GPWS initialization
private _modeCurrent = _vehicle getVariable [QGVAR(GPWSmode), "init"];
if (_modeCurrent isEqualTo "init") then {
	_vehicle setVariable [QGVAR(GPWSvolumeLow), GVAR(defaultVolumeLow), true];

	if !(GVAR(personallDefault) isEqualTo "none") exitWith {
		_vehicle setVariable [QGVAR(GPWSmode), GVAR(personallDefault), true];
	};

	if (getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> QGVAR(defaultGPWS)) isEqualTo "f16") exitWith {
		_vehicle setVariable [QGVAR(GPWSmode), "f16", true];
	};

	_vehicle setVariable [QGVAR(GPWSmode), "off", true];
};
