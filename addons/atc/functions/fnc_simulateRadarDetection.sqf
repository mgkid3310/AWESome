#include "script_component.hpp"

params ["_monitor", "_target", ["_radarTargetSize", -1]];

private _radarParams = _monitor getVariable [QGVAR(radarParams), []];
_radarParams params [["_radar", _monitor], ["_radarRange", 30], ["_isMaster", false], ["_performanceParams", []], ["_advancedParams", []]];
_performanceParams params [["_counterStealth", 0], ["_vClutterMultiplier", 1], ["_gClutterMultiplier", 1]];
_advancedParams params [["_azimuthBandwith", 1], ["_pulseWidth", 0.000001]];

if (_isMaster) then {[100, 0] select (isTouchingGround _target)};

if (terrainIntersect [ASLToAGL getPosASL _radar, ASLToAGL getPosASL _target]) exitWith {0};

private _deadzoneRange = _pulseWidth * GVAR(speedOfLight) / 2; // m
private _distance = _deadzoneRange max (_radar distance _target); // m

if !(_distance > _deadzoneRange) exitWith {0};

if !(_radarTargetSize > 0) then {
	_radarTargetSize = getNumber (configFile >> "CfgVehicles" >> (typeOf _target) >> "radarTargetSize");
};
private _radarCrossSection = _radarTargetSize ^ 4; // x5m^2
private _rangeRatio = 1000 * _radarRange / _distance;

private _detectingPower = _radarCrossSection * _rangeRatio ^ 4; // 1 for 5m^2 RCS aircraft at maximum radar range, high altitude

private _altAGLS = getPos _target select 2;
private _altASL = getPosASL _target select 2;
private _altRadar = 1 max (_altAGLS min _altASL);

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
