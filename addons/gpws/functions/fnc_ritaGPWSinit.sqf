#include "script_component.hpp"

private _vehicle = _this select 0;

_vehicle setVariable [QGVAR(isGPWSready), -1];
_vehicle setVariable [QGVAR(isGPWSreadyBeep), -1];
[_vehicle, "rita_online"] spawn FUNC(speakGPWS);
