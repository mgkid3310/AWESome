#include "script_component.hpp"

params ["_vehicle", "_throttle"];

private _fuelFlow = 0.3 * _throttle ^ 2 + 0.03;
_fuelFlow = _fuelFlow * (_vehicle getVariable [QGVAR(fuelFlowMultiplier), 1]) * GVAR(fuelFlowMultiplierGlobal);

_fuelFlow
