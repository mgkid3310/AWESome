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

// check if GPWS is already running
private _modeCurrent = _vehicle getVariable ["orbisGPWSmode", ""];
switch (_modeCurrent) do {
	case ("f16"): {
		[_vehicle, _modeCurrent] call orbis_gpws_fnc_startGPWS;
	};
	case ("b747"): {
		[_vehicle, _modeCurrent] call orbis_gpws_fnc_startGPWS;
	};
	default {};
};

// set default GPWS
if (_GPWSenabled isEqualType 0) then {
	if (getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "orbisGPWS_default") isEqualTo "f16") then {
		[_vehicle, "f16", true] call orbis_gpws_fnc_startGPWS;
	};
};
