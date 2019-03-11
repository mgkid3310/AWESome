private _vehicle = _this select 0;

if !((player isEqualTo driver _vehicle) && orbis_aerodynamics_enabled) exitWith {};

private _modelvelocity = velocityModelSpace _vehicle;
_vehicle setVelocityModelSpace (_modelvelocity set [0, 0]);
