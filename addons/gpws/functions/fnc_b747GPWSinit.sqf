#include "script_component.hpp"

private _vehicle = _this select 0;

_vehicle setVariable [QGVAR(GPWSready), true];
_vehicle setVariable [QGVAR(GPWSreadyBeep), true];
_vehicle setVariable [QGVAR(minWarnLevel), 0];
_vehicle setVariable [QGVAR(altInformLevel), 2000];
