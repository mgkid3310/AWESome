#include "script_component.hpp"
#include "header_macros.hpp"

params ["_vehicle", "_sound", ["_delay", 0], ["_mode", QGVAR(nextGPWStime)]];

private _duration = getNumber (configFile >> "CfgSounds" >> _sound >> "length");
private _volumeLow = _vehicle getVariable [QGVAR(GPWSvolumeLow), false];
if (_volumeLow) then {
	_sound = format ["%1_low", _sound];
};

if !((alive _vehicle) && (player in _vehicle)) exitWith {};

[QEGVAR(main,playSoundVehicle), [_sound]] call CBA_fnc_localEvent;

if (isNil {_duration}) then {_duration = 0};
_vehicle setVariable [_mode, time + _duration + _delay];
