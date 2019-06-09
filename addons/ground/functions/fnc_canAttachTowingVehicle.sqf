#include "script_component.hpp"

private _car = _this select 0;

if (!(_car getVariable [QGVAR(hasTowBarDeployed), false]) || (_car getVariable [QGVAR(isTowingPlane), false])) exitWith {false};

private _towArray = [_car] call FUNC(getTowTarget);

!(isNull (_towArray select 0))
