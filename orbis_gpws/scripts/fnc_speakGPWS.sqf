#include "header_macros.hpp"

private _vehicle = _this select 0;
private _sound = _this select 1;
private _duration = _this select 2;
private _mode = param [3, "orbisGPWSready"];

if !((alive _vehicle) && (player in _vehicle)) exitWith {};
playSound _sound;

if (isNil {_duration}) exitWith {};
_vehicle setVariable [_mode, false];
sleep _duration;
_vehicle setVariable [_mode, true];
DEV_CHAT("orbis_gpws: GPWS sleep done");
