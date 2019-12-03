#include "script_component.hpp"

params ["_posASL", ["_dynamicWindMode", GVAR(dynamicWindMode)]];

if !(_dynamicWindMode > 0) exitWith {wind};

private _altRadar = ((_posASL select 2) - (getTerrainHeightASL _posASL)) max 1;

// surface wind deflection
private ["_surfaceNormal", "_windNormal", "_dotProduct", "_surfaceRatio", "_surfaceGradient", "_altitudeFactor", "_deflectedVector", "_deflectedWind"];
private _globalWind = wind;
private _windMagnitude = vectorMagnitude _globalWind;
if (_windMagnitude > 0.01) then {
	_surfaceNormal = surfaceNormal _posASL;
	_windNormal = vectorNormalized _globalWind;

	_dotProduct = -0.866 max (_surfaceNormal vectorDotProduct _windNormal) min 0.866;
	_surfaceRatio = _dotProduct / (_dotProduct - 1);
	_surfaceGradient = vectorNormalized ((_surfaceNormal vectorMultiply _surfaceRatio) + (_windNormal vectorMultiply (1 - _surfaceRatio)));

	_altitudeFactor = (3 / _altRadar) min 1;
	_deflectedVector = ((_windNormal vectorMultiply _altitudeFactor) vectorAdd (_surfaceGradient vectorMultiply (1 - _altitudeFactor)));

	_deflectedWind = _deflectedVector vectorMultiply _windMagnitude;
} else {
	_deflectedWind = _globalWind;
};

// sea brease
private _seaBrease = [0, 0, 0];

// wake turbulence
private ["_wakeTurbulence"];
if !(_dynamicWindMode < 2) then {
	_wakeTurbulence = [0, 0, 0];
} else {
	_wakeTurbulence = [0, 0, 0];
};

// sum wind components
private _returnWind = _deflectedWind + _seaBrease + _wakeTurbulence;

_returnWind
