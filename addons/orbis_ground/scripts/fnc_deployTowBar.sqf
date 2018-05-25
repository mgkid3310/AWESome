private _car = _this select 0;

private _angle = getNumber (configFile >> "CfgVehicles" >> (typeOf _car) >> "orbis_towBarAngle");
private _posRel = getArray (configFile >> "CfgVehicles" >> (typeOf _car) >> "orbis_towBarPosRel");

private _bar = "Land_TowBar_01_F" createVehicle getPos _car;
_bar attachTo [_car, _posRel];
_bar setVectorDirAndUp [[0, -(cos _angle), -(sin _angle)], [0, (sin _angle), (cos _angle)]];

_car setVariable ["orbis_hasTowBarDeployed", true];
_car setVariable ["orbis_towBarObject", _bar];
