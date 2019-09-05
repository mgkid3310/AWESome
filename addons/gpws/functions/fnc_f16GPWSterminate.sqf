#include "script_component.hpp"

private _vehicle = _this select 0;

_vehicle setVariable [QGVAR(f16Data), nil];

private _gpwsEventHandlers = _vehicle getVariable [QGVAR(GPWSeventHandlers), [_chaffFlare, _incomingMSL]];
_vehicle removeEventHandler ["Fired", _gpwsEventHandlers select 0];
_vehicle removeEventHandler ["IncomingMissile", _gpwsEventHandlers select 1];

GVAR(f16ChaffFlareProjectiles) = [];
