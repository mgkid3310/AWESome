private _vehicle = _this select 0;
private _aerodynamicsEnabled = missionNamespace getVariable ["orbis_aerodynamics_enabled", false];

if (!(player isEqualTo driver _vehicle) || !(_aerodynamicsEnabled)) exitWith {};

private _modelvelocity = velocityModelSpace _vehicle;
_vehicle setVelocityModelSpace (_modelvelocity set [0, 0]);
