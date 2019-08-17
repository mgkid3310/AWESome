#include "script_component.hpp"

params ["_throttle", "_fuelFlowMultiplier"];

private _fuelFlow = 0.3 * _throttle ^ 2 + 0.03;
_fuelFlow = _fuelFlow * _fuelFlowMultiplier;

_fuelFlow
