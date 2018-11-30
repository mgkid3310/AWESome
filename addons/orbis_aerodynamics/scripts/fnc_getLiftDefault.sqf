params ["_paramArray", "_liftArray", "_speedMax", "_angleOfIndicence"];
_paramArray params ["_modelvelocity", "_mass"];

private _liftValue = 0;
private _speedKPH = (_modelvelocity vectorDotProduct [0, cos deg _angleOfIndicence, sin deg _angleOfIndicence]) * 3.6;
private _speedStep = _speedMax / 10;

if (_speedKPH < (_speedStep * (count _liftArray - 1))) then {
    private _speedIndex = (0 max floor (_speedKPH / _speedStep)) min (count _liftArray - 2);
    private _speedLower = _speedStep * _speedIndex;
    private _speedUpper = _speedStep * (_speedIndex + 1);
    private _coefMin = _liftArray select _speedIndex;
    private _coefMax = _liftArray select (_speedIndex + 1);
    _liftValue = linearConversion [_speedLower, _speedUpper, _speedKPH, _coefMin, _coefMax, true];
} else {
    _liftValue = _liftArray select (count _liftArray - 1);
};

private _liftForceDefault = [0, 0, _liftValue * 9.81 * _mass];

// report if needed (dev script)
// diag_log format ["orbis_aerodynamics _liftForceDefault: %1", _liftForceDefault];

_liftForceDefault
