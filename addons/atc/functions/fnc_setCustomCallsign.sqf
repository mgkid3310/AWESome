#include "script_component.hpp"

private _vehicle = _this select 0;
private _customCallsign = _this select 1;

_vehicle setVariable [QGVAR(customCallsign), _customCallsign, true];