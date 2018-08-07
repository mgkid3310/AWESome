params ["_paramArray", "_liftArray", "_speedMax", "_angleOfIndicence"];
_paramArray params ["_velocity", "_mass", "_densityRatio"];

private _liftCoef = 0;
private _liftForce = [0, 0, 0];
private _speedKPH = (_velocity vectorDotProduct [0, cos deg _angleOfIndicence, sin deg _angleOfIndicence]) * 3.6;
private _speedStep = _speedMax / 10;

if (_speedKPH < (_speedStep * (count _liftArray - 1))) then {
    private _speedIndex = (0 max floor (_speedKPH / _speedStep)) min (count _liftArray - 2);
    private _speedLower = _speedStep * _speedIndex;
    private _speedUpper = _speedStep * (_speedIndex + 1);
    private _coefMin = _liftArray select _speedIndex;
    private _coefMax = _liftArray select (_speedIndex + 1);
    _liftCoef = linearConversion [_speedLower, _speedUpper, _speedKPH, _coefMin, _coefMax, true];
} else {
    _liftCoef = _liftArray select (count _liftArray - 1);
};

_liftForce set [2, _liftCoef * 9.81 * _mass * _densityRatio];

_liftForce
