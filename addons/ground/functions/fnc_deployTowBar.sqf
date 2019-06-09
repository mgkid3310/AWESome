#include "script_component.hpp"

private _car = _this select 0;

private _angle = getNumber (configFile >> "CfgVehicles" >> (typeOf _car) >> QGVAR(towBarAngle));
private _posRel = getArray (configFile >> "CfgVehicles" >> (typeOf _car) >> QGVAR(towBarPosRel));

private _bar = "Land_TowBar_01_F" createVehicle getPos _car;
_bar attachTo [_car, _posRel];
_bar setVectorDirAndUp [[0, -(cos _angle), -(sin _angle)], [0, (sin _angle), (cos _angle)]];

_car setVariable [QGVAR(hasTowBarDeployed), true, true];
_car setVariable [QGVAR(towBarObject), _bar, true];
