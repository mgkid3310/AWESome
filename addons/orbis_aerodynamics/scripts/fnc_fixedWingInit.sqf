private _vehicle = _this select 0;

private _aeroConfigs = [_vehicle] call orbis_aerodynamics_fnc_getAeroConfig;
[_vehicle, time, _aeroConfigs] spawn orbis_aerodynamics_fnc_fixedWingLoop;
