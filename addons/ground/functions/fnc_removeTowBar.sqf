#include "script_component.hpp"

private _car = _this select 0;

private _bar = _car getVariable [QGVAR(towBarObject), objNull];
deleteVehicle _bar;

_car setVariable [QGVAR(hasTowBarDeployed), false];
_car setVariable [QGVAR(towBarObject), objNull];
