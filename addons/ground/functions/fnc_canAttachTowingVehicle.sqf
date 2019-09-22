#include "script_component.hpp"

params ["_car"];

if (!(_car getVariable [QGVAR(hasTowBarDeployed), false]) || (_car getVariable [QGVAR(isTowingPlane), false])) exitWith {false};

private _towArray = [_car] call FUNC(getTowTarget);

!(isNull (_towArray select 0))
