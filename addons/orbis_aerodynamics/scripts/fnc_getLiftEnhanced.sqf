params ["_paramArray", "_liftArray", "_speedMax", "_angleOfIndicence"];
_paramArray params ["_trueAirVelocity", "_massStandard", "_massError", "_densityRatio", "_height"];

// if (_massError) exitWith {[0, 0, 0]};

private _airVel = _modelvelocity vectorMultiply -1;
private _speedKPH = (_trueAirVelocity vectorDotProduct [0, cos deg _angleOfIndicence, sin deg _angleOfIndicence]) * 3.6;
private _liftValue = [_liftArray, _speedMax, 1.25 / (count _liftArray - 1), _speedKPH] call orbis_aerodynamics_fnc_extractCoefArray;

private _liftForceEnhanced = (vectorNormalized _airVel) vectorCrossProduct [_liftValue * orbis_aerodynamics_liftGFactor * _massStandard * _densityRatio, 0, 0];
_liftForceEnhanced set [2, abs (_liftForceEnhanced select 2)];

private _hOverD = (((_height max 0) + orbis_aerodynamics_wingHeight) / orbis_aerodynamics_wingSpan);
private _geMultiplier = orbis_aerodynamics_geFactor / (_hOverD + orbis_aerodynamics_geFactor);
_liftForceEnhanced = _liftForceEnhanced vectorMultiply (1 + (_geMultiplier * orbis_aerodynamics_geLiftMultiplier));

// report if needed (dev script)
// diag_log format ["orbis_aerodynamics _liftForceEnhanced: %1", _liftForceEnhanced];

_liftForceEnhanced
