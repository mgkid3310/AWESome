private _car = _this select 0;

private _bar = _car getVariable ["awesome_towBarObject", objNull];
deleteVehicle _bar;

_car setVariable ["awesome_hasTowBarDeployed", false];
_car setVariable ["awesome_towBarObject", objNull];
