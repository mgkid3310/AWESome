#include "script_component.hpp"

private _vehicle = _this select 0;

_vehicle setVariable [QGVAR(isGPWSready), false];
_vehicle setVariable [QGVAR(isGPWSreadyBeep), true];
[_vehicle, "rita_online"] spawn FUNC(speakGPWS);
