private _velocity = _this select 0;
private _liftArray = _this select 1;
private _speedMax = _this select 2;
private _mass = _this select 3;

private _liftCoef = 0;
private _liftForce = [0, 0, 0];
private _speedKPH = (_velocity select 1) * 3.6;

if (_speedKPH >= (_speedMax * (count _liftArray - 1) / 10)) then {
    _liftCoef = _liftArray select (count _liftArray - 1);
} else {
    private _speedIndex = round (_speedKPH * 10 / _speedMax);
    private _speedMin = _speedMax * _speedIndex / 10;
    private _speedMax = _speedMax * (_speedIndex + 1) / 10;
    private _coefMin = _liftArray select _speedIndex;
    private _coefMax = _liftArray select (_speedIndex + 1);
    _liftCoef = linearConversion [_speedMin, _speedMax, _speedKPH, _coefMin, _coefMax];
};

_liftForce set [2, _liftCoef * 9.81 * _mass];

_liftForce
