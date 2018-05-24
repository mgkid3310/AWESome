private _velocity = _this select 0;
private _liftArray = _this select 1;
private _speedMax = _this select 2;
private _angleOfIndicence = _this select 3;
private _mass = _this select 4;

private _liftCoef = 0;
private _liftForce = [0, 0, 0];
private _speedKPH = (_velocity vectorDotProduct [0, cos deg _angleOfIndicence, sin deg _angleOfIndicence]) * 3.6;
private _speedStep = _speedMax / 10;

if (_speedKPH < (_speedStep * (count _liftArray - 1))) then {
    private _speedIndex = (1 + floor (_speedKPH / _speedStep)) min (count _liftArray - 2);
    private _speedLower = _speedStep * _speedIndex;
    private _speedUpper = _speedStep * (_speedIndex + 1);
    private _coefMin = _liftArray select _speedIndex;
    private _coefMax = _liftArray select (_speedIndex + 1);
    _liftCoef = linearConversion [_speedLower, _speedUpper, _speedKPH, _coefMin, _coefMax];
} else {
    _liftCoef = _liftArray select (count _liftArray - 1);
};

_liftForce set [2, _liftCoef * 9.81 * _mass];

_liftForce
