#include "script_component.hpp"

private _vehicle = _this select 0;

_vehicle setVariable [QGVAR(GPWSready), false];
_vehicle setVariable [QGVAR(GPWSreadyBeep), true];
[_vehicle, "rita_online"] spawn FUNC(speakGPWS);
