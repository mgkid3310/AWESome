private _vehicle = _this select 0;
private _time = _this select 1;
private _interval = _this select 2;

private _timeOld = time;
private _velOld = velocity _vehicle;
private _aeroConfigs = [_vehicle] call orbis_aerodynamics_fnc_getAeroConfig;

sleep _interval;

while {time > (_timeOld + _time)} do {
    private _accel = (velocity _vehicle - _velOld) / _interval;
    private _dragGround = [_modelvelocity, _dragArray] call orbis_aerodynamics_fnc_getDrag;
    private _dragTAS = [_trueAirVelocity, _dragArray] call orbis_aerodynamics_fnc_getDrag;
    private _liftGround = [_modelvelocity, _liftArray, _speedMax] call orbis_aerodynamics_fnc_getlift;
    private _liftTAS = [_trueAirVelocity, _liftArray, _speedMax] call orbis_aerodynamics_fnc_getlift;

    diag_log format ["orbis_aerodynamics _accel: %1, _dragGround: %2, _dragTAS: %3, _liftGround: %4, _liftTAS: %5", _accel, _dragGround, _dragTAS. _liftGround, _liftTAS];

    sleep _interval;
};
