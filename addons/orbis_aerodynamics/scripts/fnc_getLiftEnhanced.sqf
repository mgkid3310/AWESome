params ["_paramArray", "_liftArray", "_speedMax", "_angleOfIndicence"];
_paramArray params ["_trueAirVelocity", "_mass", "_densityRatio"];

private _liftCoef = 0;
private _airVel = _modelvelocity vectorMultiply -1;
private _speedKPH = (_trueAirVelocity vectorDotProduct [0, cos deg _angleOfIndicence, sin deg _angleOfIndicence]) * 3.6;
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

private _liftForceEnhanced = (vectorNormalized _airVel) vectorCrossProduct [_liftCoef * 9.81 * _mass * _densityRatio, 0, 0];
_liftForceEnhanced set [2, abs (_liftForceEnhanced select 2)];

// report if needed (dev script)
// diag_log format ["orbis_aerodynamics _liftForceEnhanced: %1", _liftForceEnhanced];

_liftForceEnhanced
