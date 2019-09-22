#include "script_component.hpp"

params ["_car"];

private _bar = _car getVariable [QGVAR(towBarObject), objNull];
deleteVehicle _bar;

_car setVariable [QGVAR(hasTowBarDeployed), false];
_car setVariable [QGVAR(towBarObject), objNull];
