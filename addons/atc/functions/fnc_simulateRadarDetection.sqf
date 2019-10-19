#include "script_component.hpp"

params ["_monitor", "_target", ["_radarTargetSize", -1]];

private _radarParams = _monitor getVariable [QGVAR(radarParams), []];
_radarParams params [["_radar", _monitor], ["_isMaster", false]];

if (_isMaster) then {[GVAR(minRadarDetection), 0] select (isTouchingGround _target)};

private _performanceParams = _radar getVariable [QGVAR(performanceParams), []];
private _radarDetailParams = _radar getVariable [QGVAR(radarDetailParams), []];
if (_radarDetailParams isEqualType "") then {
	private _index = (GVAR(radarParameterOptions) apply {toUpper (_x select 0)}) find toUpper _radarDetailParams;
	_radarDetailParams = if (_index < 0) then {[]} else {GVAR(radarParameterOptions) select _index select 1};
};

_performanceParams params [["_radarPos", _radar], ["_radarRange", 30], ["_counterStealth", 0], ["_volumeCR", 10 ^ 3], ["_groundCR", 10 ^ 3]];
_radarDetailParams params [["_radarFrequencyGHz", 16.5], ["_pulseWidthMicroS", 1.25], ["_azimuthBeamwidth", 2.2], ["_elevationBeamwidth", 3.8]];

private ["_posRadarASL", "_posTargetASL"];
private _posRadarASL = if (_radarPos isEqualType []) then {_radarPos} else {getPosASL _radarPos};
private _posTargetASL = if (_target isEqualType []) then {_target} else {getPosASL _target};

if (terrainIntersect [ASLToAGL _posRadarASL, ASLToAGL _posTargetASL]) exitWith {0};

private _deadzoneRange = _pulseWidthMicroS * (10 ^ -6) * GVAR(speedOfLight) / 2; // m
private _distance = _deadzoneRange max (_posRadarASL vectorDistance _posTargetASL); // m

if !(_distance > _deadzoneRange) exitWith {0};

if ((_radarTargetSize < 0) && (_target isEqualType "")) then {
	_radarTargetSize = getNumber (configFile >> "CfgVehicles" >> (typeOf _target) >> "radarTargetSize");
};
private _radarCrossSection = 5 * _radarTargetSize ^ 4; // m^2
private _rangeRatio = 1000 * _radarRange / _distance;

private _detectingPower = _radarCrossSection * _rangeRatio ^ 4; // 1 for 5m^2 RCS aircraft at maximum radar range, high altitude

private _altAGL = (ASLToAGL _posTargetASL) select 2;
private _altASL = _posTargetASL select 2;
private _altRadar = 0 max (_altAGL min _altASL);

private _azimuthRadius = _distance * tan (_azimuthBeamwidth / 2);
private _elevationRadius = _distance * tan (_elevationBeamwidth / 2);
private _cellLength = _pulseWidthMicroS * (10 ^ -6) * GVAR(speedOfLight) / 2;
private _psi = acos ((_posRadarASL distance2D _posTargetASL) / _distance);
private _volumeClutterCell = pi * _azimuthRadius * _elevationRadius * _cellLength;
private _groundClutterArea = [_azimuthRadius, _elevationRadius, _cellLength, _altRadar, _psi] call FUNC(getGroundClutterArea); // m^2

private _rainfallRate = 16 * rain * ([0, 1] select (overcast > 0.5)); // mm/hr
private _volumeReflectivity = ((6 * 10 ^ -14) * _rainfallRate ^ 1.6) / ((GVAR(speedOfLight) / (_radarFrequencyGHz * 10 ^ 9)) ^ 4); // m^-1
private _terrainReflectivity = 10 ^ linearConversion [0, 90, 90 - abs _psi, -3, -2, true];

private _volumeClutter = ((_volumeClutterCell * _volumeReflectivity) / (_volumeCR * 10 ^ 0.32)) * _rangeRatio ^ 4;
private _groundClutter = ((_groundClutterArea * _terrainReflectivity) / (_groundCR * 10 ^ 0.16)) * _rangeRatio ^ 4;
private _radarClutter = 5 + GVAR(volumeClutterFactor) * _volumeClutter + GVAR(groundClutterFactor) * _groundClutter; // 5 for background noise

private _radarDetection = _detectingPower / _radarClutter;

// diag_log str [_target, _rangeRatio, _detectingPower, _volumeClutter, _groundClutter, _psi, _volumeClutterCell, _groundClutterArea, _terrainReflectivity];
_radarDetection
