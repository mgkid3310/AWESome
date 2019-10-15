#include "script_component.hpp"

params ["_monitor", "_target", ["_radarTargetSize", -1]];

private _radarParams = _monitor getVariable [QGVAR(radarParams), []];
_radarParams params [["_radar", _monitor], ["_radarRange", 30], ["_isMaster", false], ["_performanceParams", []], ["_advancedParams", []]];
_performanceParams params [["_counterStealth", 0], ["_vClutterMultiplier", 1], ["_gClutterMultiplier", 1]];
_advancedParams params [["_radarFrequencyGHz", 10], ["_azimuthBandwith", 1], ["_pulseWidthMicroS", 1]];

if (_isMaster) then {[100, 0] select (isTouchingGround _target)};

private ["_posRadarASL", "_posTargetASL"];
private _posRadarASL = if (_radar isEqualType []) then {_radar} else {getPosASL _radar};
private _posTargetASL = if (_target isEqualType []) then {_target} else {getPosASL _target};
if (terrainIntersect [ASLToAGL _posRadarASL, ASLToAGL _posTargetASL]) exitWith {0};

private _deadzoneRange = _pulseWidth * GVAR(speedOfLight) / 2; // m
private _distance = _deadzoneRange max (_posRadarASL distance _posTargetASL); // m

if !(_distance > _deadzoneRange) exitWith {0};

if ((_radarTargetSize < 0) && (_target isEqualType "")) then {
	_radarTargetSize = getNumber (configFile >> "CfgVehicles" >> (typeOf _target) >> "radarTargetSize");
};
private _radarCrossSection = _radarTargetSize ^ 4; // x5m^2
private _rangeRatio = 1000 * _radarRange / _distance;

private _detectingPower = _radarCrossSection * _rangeRatio ^ 4; // 1 for 5m^2 RCS aircraft at maximum radar range, high altitude

private _altAGL = (ASLToAGL _posTargetASL) select 2;
private _altASL = _posTargetASL select 2;
private _altRadar = 0 max (_altAGL min _altASL);

private _cellRadius = _distance * tan (_azimuthBandwith / 2);
private _cellLength = _pulseWidthMicroS * (10 ^ -6) * GVAR(speedOfLight) / 2;
private _psi = acos ((_posRadarASL distance2D _posTargetASL) / _distance);
private _volumeClutterCell = pi * _cellLength * _cellRadius ^ 2;
private _groundClutterArea = [_cellRadius, _cellLength, _altRadar, _psi] call FUNC(getCylinderlutterArea); // m^2

private _volumeReflectivity = 10 ^ (4 * log _radarFrequencyGHz + linearConversion [0, 1, rain, -12, -9]);
private _terrainReflectivity = 0.001;

private _volumeClutter = GVAR(volumeClutterFactor) * _volumeReflectivity * _volumeClutterCell * _rangeRatio ^ 4;
private _groundClutter = GVAR(groundClutterFactor) * _groundClutterArea * _terrainReflectivity * _rangeRatio ^ 4;
private _radarClutter = 1 + _volumeClutter * _vClutterMultiplier + _groundClutter * _gClutterMultiplier; // 1 for background noise

private _radarDetection = _detectingPower / _radarClutter;

_radarDetection
// [_rangeRatio, _detectingPower, _volumeClutter, _groundClutter, _psi, _groundClutterArea]
