#include "script_component.hpp"

params ["_posASL", ["_dynamicWindMode", GVAR(dynamicWindMode)]];

if !(_dynamicWindMode > 0) exitWith {wind};

private _altRadar = ((_posASL select 2) - (getTerrainHeightASL _posASL)) max 1;

// calculate global wind
private _altitudeProfile = 1.219 * (exp (-0.15 * _altRadar / 80) - exp (-3.2175 * _altRadar / 80));
private _windVariability = linearConversion [0, 0.5, gusts, 0, GVAR(maxWindVariability), true];
private _perlinNoise = 0; // 0 random [CBA_missionTime / 60, 0.5]; // perlin noise with 60s grid size
private _globalWind = wind vectorMultiply (1 + _altitudeProfile * _windVariability * (_perlinNoise - 0.5));

// wind gust
private _timePassed = 0;
private _timeDuration = 60;
if !(_dynamicWindMode < 2) then {
	_globalWind = _globalWind vectorMultiply (1 + _altitudeProfile * gusts * GVAR(gustMultiplier) * sin (180 * _timePassed / _timeDuration));
};

// surface wind deflection
private ["_surfaceNormal", "_windNormal", "_dotProduct", "_surfaceRatio", "_surfaceGradient", "_altitudeFactor", "_deflectedVector", "_deflectedWind"];
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
private _returnWind = _deflectedWind vectorAdd _seaBrease vectorAdd _wakeTurbulence;

_returnWind
