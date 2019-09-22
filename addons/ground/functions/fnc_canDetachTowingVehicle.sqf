#include "script_component.hpp"

params ["_car"];

private _isTowing = _car getVariable [QGVAR(isTowingPlane), false];

_isTowing && (abs (speed _car) < 1)
