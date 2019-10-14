#include "script_component.hpp"

params ["_monitor", "_target", ["_radarTargetSize", -1]];

private _radarParams = _monitor getVariable [QGVAR(radarParams), []];
_radarParams params [["_radar", _monitor], ["_radarRange", 30], ["_isMaster", false], ["_performanceParams", []], ["_advancedParams", []]];
_performanceParams params [["_counterStealth", 0], ["_vClutterMultiplier", 1], ["_gClutterMultiplier", 1]];
_advancedParams params [["_azimuthBandwith", 1], ["_pulseWidth", 0.000001]];

if (_isMaster) then {[100, 0] select (isTouchingGround _target)};

private ["_posRadarASL", "_posTargetASL"];
if (_radar isEqualType []) then {
	_posRadarASL = _radar;
} else {
	_posRadarASL = getPosASL _radar;
};
if (_target isEqualType []) then {
	_posTargetASL = _target;
} else {
	_posTargetASL = getPosASL _target;
};
if (terrainIntersect [ASLToAGL _posRadarASL, ASLToAGL _posTargetASL]) exitWith {0};

private _deadzoneRange = _pulseWidth * GVAR(speedOfLight) / 2; // m
private _distance = _deadzoneRange max (_posRadarASL distance _posTargetASL); // m

if !(_distance > _deadzoneRange) exitWith {0};

if ((_radarTargetSize < 0) && (_target isEqualType "")) then {
	_radarTargetSize = getNumber (configFile >> "CfgVehicles" >> (typeOf _target) >> "radarTargetSize");
} else {
	_radarTargetSize = 1;
};
private _radarCrossSection = _radarTargetSize ^ 4; // x5m^2
private _rangeRatio = 1000 * _radarRange / _distance;

private _detectingPower = _radarCrossSection * _rangeRatio ^ 4; // 1 for 5m^2 RCS aircraft at maximum radar range, high altitude

private _altAGL = (ASLToAGL _posTargetASL) select 2;
private _altASL = _posTargetASL select 2;
private _altRadar = 1 max (_altAGL min _altASL);

private _radius = _distance * tan (_azimuthBandwith / 2);
private _psi = acos ((_posRadarASL distance2D _posTargetASL) / _distance);
private _altEff = _radius min (_altRadar / cos _psi);
private _altFactor = sqrt ((_radius ^ 2) - (_altEff ^ 2));
private _angleFactor = 1 min (_pulseWidth * GVAR(speedOfLight) * (tan _psi) / (4 * _radius));

private _volumeClutter = GVAR(volumeClutterFactor) * rain * _rangeRatio ^ 2;
private _groundClutter = GVAR(groundClutterFactor) * _altFactor * _angleFactor * _rangeRatio ^ 2;
private _radarClutter = 1 + _volumeClutter * _vClutterMultiplier + _groundClutter * _gClutterMultiplier; // 1 for background noise

private _radarDetection = _detectingPower / _radarClutter;

_radarDetection
