#include "header_macros.hpp"

params ["_unit", "_position", "_vehicle", "_turret"];

DEV_CHAT("orbis_gpws: getInMan run");

// check if has GPWS enabled
private _GPWSenabled = _vehicle getVariable ["orbisGPWSenabled", 0];
if (_GPWSenabled isEqualType true) then {
	if !(_GPWSenabled) exitWith {};
} else {
	if !(getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "orbisGPWS_enabled") > 0) exitWith {
		_vehicle setVariable ["orbisGPWSenabled", false];
	};
};
_vehicle setVariable ["orbisGPWSenabled", true];

// GPWS initialization
if (_GPWSenabled isEqualType 0) then {
	if (getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "orbisGPWS_default") isEqualTo "f16") exitWith {
		_vehicle setVariable ["orbisGPWSmode", "f16", true];
	};

	_vehicle setVariable ["orbisGPWSmode", "", true];
};
