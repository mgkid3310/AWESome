#include "script_component.hpp"

params ["_paramArray", "_paramLift", "_speedMax", "_angleOfIndicence"];
_paramArray params ["_modelvelocity", "_massCurrent", "_massError"];
_paramLift params ["_liftArray", "_liftMultiplier", "_flapsFCoef", "_flapPhase"];

// if (_massError) exitWith {[0, 0, 0]};

private _speedKPH = (_modelvelocity vectorDotProduct [0, cos deg _angleOfIndicence, sin deg _angleOfIndicence]) * 3.6;
private _liftValue = [_liftArray, _speedMax, 1.25 / (count _liftArray - 1), _speedKPH] call FUNC(extractCoefArray);

GVAR(liftFlapFactor) params ["_speedL", "_speedH", "_factorL", "_factorH"];
private _flapFactor = _flapsFCoef * _flapPhase * linearConversion [_speedL, _speedH, _speedKPH / _speedMax, _factorL, _factorH, true];
_liftValue = _liftValue * (1 + _flapFactor);

private _liftForceDefault = [0, 0, _liftValue * GVAR(liftGFactor) * _massCurrent];

// report if needed (dev script)
// diag_log format ["orbis_aerodynamics _liftForceDefault: %1", _liftForceDefault];

_liftForceDefault
