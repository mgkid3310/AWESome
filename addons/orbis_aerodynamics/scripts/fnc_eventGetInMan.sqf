params ["_unit", "_position", "_vehicle", "_turret"];

// check if aerodynamics option is enabled and vehicle is a plane
private _aerodynamicsEnabled = missionNamespace getVariable ["orbis_edition_aerodynamics_enabled", false];
if (_aerodynamicsEnabled && (_vehicle in entities "Plane")) then {
    [_vehicle, _unit] spawn orbis_aerodynamics_fnc_fixedWingInit;
};
