private _car = _this select 0;

private _bar = _car getVariable ["orbis_towBarObject", objNull];
deleteVehicle _bar;

_car setVariable ["orbis_hasTowBarDeployed", false];
_car setVariable ["orbis_towBarObject", objNull];
