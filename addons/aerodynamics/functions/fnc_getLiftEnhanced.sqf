#include "script_component.hpp"

params ["_paramEnhanced", "_paramLift", "_speedMax", "_angleOfIndicence"];
_paramEnhanced params ["_trueAirVelocity", "_massStandard", "_massError", "_densityRatio", "_height"];
_paramLift params ["_liftArray", "_liftMultiplier", "_flapsFCoef", "_flapPhase"];

// if (_massError) exitWith {[0, 0, 0]};

private _airVel = _trueAirVelocity vectorMultiply -1;
private _speedKPH = (_trueAirVelocity vectorDotProduct [0, cos deg _angleOfIndicence, sin deg _angleOfIndicence]) * 3.6;
private _liftValue = [_liftArray, _speedMax, 1.25 / (count _liftArray - 1), _speedKPH] call FUNC(extractCoefArray);

private _hOverD = (((_height max 0) + GVAR(wingHeight)) / GVAR(wingSpan));
private _geMultiplier = GVAR(geFactor) / (_hOverD + GVAR(geFactor));
_liftValue = _liftValue * (1 + (_geMultiplier * GVAR(geLiftMultiplier)));

GVAR(liftFlapFactor) params ["_speedL", "_speedH", "_factorL", "_factorH"];
private _flapFactor = _flapsFCoef * _flapPhase * linearConversion [_speedL, _speedH, _speedKPH / _speedMax, _factorL, _factorH, true];
_liftValue = _liftValue * (1 + _flapFactor) * _liftMultiplier;

private _liftForceEnhanced = (vectorNormalized _airVel) vectorCrossProduct [_liftValue * GVAR(liftGFactor) * _massStandard * _densityRatio, 0, 0];
_liftForceEnhanced set [2, abs (_liftForceEnhanced select 2)];

// report if needed (dev script)
// diag_log format ["orbis_aerodynamics _liftForceEnhanced: %1", _liftForceEnhanced];

_liftForceEnhanced
