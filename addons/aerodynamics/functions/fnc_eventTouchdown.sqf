#include "script_component.hpp"

params ["_vehicle"];

if !(GVAR(compensateCrabLanding)) exitWith {};

if !((player isEqualTo driver _vehicle) && GVAR(enabled)) exitWith {};

private _modelVelocity = velocityModelSpace _vehicle;
_modelVelocity set [0, 0];

_vehicle setVelocityModelSpace _modelVelocity;
