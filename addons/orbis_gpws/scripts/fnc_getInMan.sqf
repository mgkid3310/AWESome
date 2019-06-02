#include "header_macros.hpp"

params ["_unit", "_role", "_vehicle", "_turret"];

DEV_CHAT("orbis_gpws: getInMan run");

if !([_unit, _vehicle, 1] call orbis_awesome_fnc_isCrew) exitWith {};

// check if has GPWS enabled
private _GPWSenabled = _vehicle getVariable ["orbis_gpws_GPWSenabled", 0];
private _enable = true;
if (_GPWSenabled isEqualType true) then {
	if !(_GPWSenabled) then {
		_enable = false;
	};
} else {
	if !(getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "orbis_gpws_GPWSenabled") > 0) then {
		_enable = false;
	};
};

if !(_enable) exitWith {
	_vehicle setVariable ["orbis_gpws_GPWSenabled", false, true];
};
_vehicle setVariable ["orbis_gpws_GPWSenabled", true, true];

// GPWS initialization
private _modeCurrent = _vehicle getVariable ["orbis_gpws_GPWSmode", "init"];
if (_modeCurrent isEqualTo "init") then {
	_vehicle setVariable ["orbis_gpws_GPWSvolumeLow", orbis_gpws_defaultVolumeLow, true];

	if !(orbis_gpws_personallDefault isEqualTo "none") exitWith {
		_vehicle setVariable ["orbis_gpws_GPWSmode", orbis_gpws_personallDefault, true];
	};

	if (getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "orbis_gpws_defaultGPWS") isEqualTo "f16") exitWith {
		_vehicle setVariable ["orbis_gpws_GPWSmode", "f16", true];
	};

	_vehicle setVariable ["orbis_gpws_GPWSmode", "off", true];
};
