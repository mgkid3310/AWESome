#include "script_component.hpp"
#include "header_macros.hpp"

private _vehicle = _this select 0;
private _sound = _this select 1;
private _duration = param [2, getNumber (configFile >> "CfgSounds" >> _sound >> "length")];
private _delay = param [3, 0];
private _mode = param [4, QGVAR(nextGPWStime)];

private _volumeLow = _vehicle getVariable [QGVAR(GPWSvolumeLow), false];
if (_volumeLow) then {
	_sound = format ["%1_low", _sound];
};

if !((alive _vehicle) && (player in _vehicle)) exitWith {};
playSound _sound;

if (isNil {_duration}) exitWith {_duration = 0};
_vehicle setVariable [_mode, time + _duration + _delay];
