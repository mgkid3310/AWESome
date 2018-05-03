#include "header_macros.hpp"

params ["_unit", "_position", "_vehicle", "_turret"];

DEV_CHAT("orbis_gpws: getIn run");

// check if has GPWS enabled
private _GPWSenabled = _vehicle getVariable ["orbisGPWSenabled", false];
if (!_GPWSenabled && !(getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "orbisGPWS_enabled") > 0)) exitWith {};
_vehicle setVariable ["orbisGPWSenabled", true];

// set default GPWS
if (getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "orbisGPWS_default") isEqualTo "f16") then {
	[_vehicle] spawn orbis_gpws_fnc_f16GPWS;
};
