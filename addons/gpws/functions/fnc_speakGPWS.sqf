#include "header_macros.hpp"

private _vehicle = _this select 0;
private _sound = _this select 1;
private _duration = param [2, getNumber (configFile >> "CfgSounds" >> _sound >> "length")];
private _delay = param [3, 0];
private _mode = param [4, "orbisGPWSready"];

private _volumeLow = _vehicle getVariable ["orbisGPWSvolumeLow", false];
if (_volumeLow) then {
    _sound = format ["%1_low", _sound];
};

if !((alive _vehicle) && (player in _vehicle)) exitWith {};
playSound _sound;

if (isNil {_duration}) exitWith {};
_vehicle setVariable [_mode, false];
sleep (_duration + _delay);
_vehicle setVariable [_mode, true];
DEV_CHAT("awesome_gpws: GPWS sleep done");
