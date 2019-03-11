#include "header_macros.hpp"

params ["_unit", "_role", "_vehicle", "_turret"];

DEV_CHAT("orbis_gpws: getInMan run");

if !([_unit, _vehicle, 1] call orbis_awesome_fnc_isCrew) exitWith {};

// check if has GPWS enabled
private _GPWSenabled = _vehicle getVariable ["orbisGPWSenabled", 0];
if (_GPWSenabled isEqualType true) then {
	if !(_GPWSenabled) exitWith {};
} else {
	if !(getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "orbisGPWS_enabled") > 0) exitWith {
		_vehicle setVariable ["orbisGPWSenabled", false, true];
	};
};
_vehicle setVariable ["orbisGPWSenabled", true, true];

// GPWS initialization
private _modeCurrent = _vehicle getVariable ["orbisGPWSmode", "init"];
if (_modeCurrent isEqualTo "init") then {
	_vehicle setVariable ["orbisGPWSvolumeLow", orbis_gpws_defaultVolumeLow, true];

	if !(orbis_gpws_personallDefault isEqualTo "none") exitWith {
		_vehicle setVariable ["orbisGPWSmode", orbis_gpws_personallDefault, true];
	};

	if (getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "orbisGPWS_default") isEqualTo "f16") exitWith {
		_vehicle setVariable ["orbisGPWSmode", "f16", true];
	};

	_vehicle setVariable ["orbisGPWSmode", "off", true];
};
