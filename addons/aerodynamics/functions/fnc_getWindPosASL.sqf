#include "script_component.hpp"

params ["_posASL", ["_dynamicWindMode", GVAR(dynamicWindMode)], ["_time", CBA_missionTime]]; // _time for debugging

if !(_dynamicWindMode > 0) exitWith {wind};

private _altRadar = ((_posASL select 2) - (getTerrainHeightASL _posASL)) max 1;

// calculate global wind
private _altitudeProfile = 1.219 * (exp (-0.15 * _altRadar / 80) - exp (-3.2175 * _altRadar / 80));
private _windVariability = linearConversion [0, 0.5, gusts, 0, GVAR(maxWindVariability), true];
private _perlinNoise = [_time / GVAR(windWavelength), 0] call EFUNC(main,perlinNoise1D); // perlin noise with 60s grid size
private _globalWind = wind vectorMultiply (1 + _altitudeProfile * _windVariability * (_perlinNoise - 0.5));

// wind gust
private ["_timePassed", "_gustStrength"];
private _timeGrid = GVAR(maxGustDuration) * floor (_time / GVAR(maxGustDuration));
private _timeDuration = linearConversion [0, 1, (_timeGrid + 1) random 1, GVAR(maxGustDuration) / 2, GVAR(maxGustDuration), true];
if (!(_dynamicWindMode < 2) && (_timeGrid random 1 < GVAR(gustChance)) && (_time < (_timeGrid + _timeDuration))) then {
	_timePassed = _time - _timeGrid;
	_gustStrength = _altitudeProfile * gusts * GVAR(gustMultiplier);
	_globalWind = _globalWind vectorMultiply (1 + _gustStrength * sin (180 * _timePassed / _timeDuration));
};

// surface wind deflection
private ["_windNormal", "_surfaceNormal", "_dotProduct", "_surfaceGradient", "_altitudeFactor", "_deflectedVector", "_deflectedWind"];
private _windMagnitude = vectorMagnitude _globalWind;
if ((getTerrainHeightASL _posASL > 0) && (_windMagnitude > 0.01)) then {
	_windNormal = vectorNormalized _globalWind;
	_surfaceNormal = surfaceNormal _posASL;

	_dotProduct = -0.866 max (_windNormal vectorDotProduct _surfaceNormal) min 0.866;
	_surfaceGradient = vectorNormalized (_windNormal vectorDiff (_surfaceNormal vectorMultiply _dotProduct));

	_altitudeFactor = (_altRadar / 80) min 1;
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
