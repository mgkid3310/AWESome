#include "header_macros.hpp"

params ["_unit", "_position", "_vehicle", "_turret"];

DEV_CHAT("orbis_gpws: getInMan run");

// check if has GPWS enabled
private _GPWSenabled = _vehicle getVariable ["orbisGPWSenabled", 0];
if (_GPWSenabled isEqualType true) then {
	if !(_GPWSenabled) exitWith {};
} else {
	if !(getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "orbisGPWS_enabled") > 0) exitWith {};
};
_vehicle setVariable ["orbisGPWSenabled", true];

// check if GPWS is already running
private _modeCurrent = getVariable ["orbisGPWSmode", ""];
switch (_modeCurrent) do {
	case ("f16"): {
		[_vehicle] spawn orbis_gpws_fnc_f16GPWS;
	};
	case ("b747"): {
		[_vehicle] spawn orbis_gpws_fnc_b747GPWS;
	};
	default {};
};

// set default GPWS
if (getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "orbisGPWS_default") isEqualTo "f16") then {
	[_vehicle] spawn orbis_gpws_fnc_f16GPWS;
};
