#include "script_component.hpp"

private _vehicle = _this select 0;

private _chaffFlare = _vehicle addEventHandler ["Fired", {_this spawn FUNC(f16ChaffFlare)}]; // f16_chaffFlare, f16_chaffFlareLow, f16_chaffFlareOut
private _incomingMSL = _vehicle addEventHandler ["IncomingMissile", {_this spawn FUNC(incomingMSL)}]; // stack list of incoming MSLs

_vehicle setVariable [QGVAR(isGPWSready), true];
_vehicle setVariable [QGVAR(isGPWSreadyBeep), true];
_vehicle setVariable [QGVAR(GPWSeventHandlers), [_chaffFlare, _incomingMSL]];
