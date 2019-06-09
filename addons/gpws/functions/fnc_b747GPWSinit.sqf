#include "script_component.hpp"

private _vehicle = _this select 0;

_vehicle setVariable [QGVAR(isGPWSready), true];
_vehicle setVariable [QGVAR(isGPWSreadyBeep), true];
_vehicle setVariable [QGVAR(minWarnLevel), 0];
_vehicle setVariable [QGVAR(altInformLevel), 2000];
