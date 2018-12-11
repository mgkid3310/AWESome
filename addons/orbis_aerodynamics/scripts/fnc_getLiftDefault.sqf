params ["_paramArray", "_liftArray", "_speedMax", "_angleOfIndicence"];
_paramArray params ["_modelvelocity", "_mass"];

private _speedKPH = (_modelvelocity vectorDotProduct [0, cos deg _angleOfIndicence, sin deg _angleOfIndicence]) * 3.6;
private _liftValue = [_liftArray, _speedMax, 10, _speedKPH] call orbis_aerodynamics_fnc_extractCoefArray;

private _liftForceDefault = [0, 0, _liftValue * 9.81 * _mass];

// report if needed (dev script)
// diag_log format ["orbis_aerodynamics _liftForceDefault: %1", _liftForceDefault];

_liftForceDefault
