#include "script_component.hpp"

params ["_throttle"];

private _fuelFlow = (0.3 * _throttle ^ 2 + 0.03) * GVAR(fuelFlowMultiplier);

_fuelFlow
