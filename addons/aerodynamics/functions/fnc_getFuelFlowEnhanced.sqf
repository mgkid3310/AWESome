#include "script_component.hpp"

params ["_throttle", "_isEngineOn", "_fuelFlowMultiplier"];

private _fuelFlow = 0.3 * _throttle ^ 2 + 0.03;
_fuelFlow = [0, _fuelFlow * _fuelFlowMultiplier] select _isEngineOn;

_fuelFlow
