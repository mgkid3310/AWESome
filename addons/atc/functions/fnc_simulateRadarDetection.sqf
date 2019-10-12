#include "script_component.hpp"

params ["_monitor", "_target", ["_radarTargetSize", -1]];

private _radarParams = _monitor getVariable [QGVAR(radarParams), []];
_radarParams params [["_radar", _monitor], ["_radarRange", 30], ["_isMaster", false], ["_charadteristicParams", []]];
_charadteristicParams params [["_counterStealth", 0], ["_vClutterMultiplier", 1], ["_gClutterMultiplier", 1]];

if (_isMaster) then {!isTouchingGround _target};

if (terrainIntersect [ASLToAGL getPosASL _radar, ASLToAGL getPosASL _target]) exitWith {};

if !(_radarTargetSize > 0) then {
	_radarTargetSize = getNumber (configFile >> "CfgVehicles" >> (typeOf _target) >> "radarTargetSize");
};
private _radarCrossSection = _radarTargetSize ^ 4; // x5m^2
private _distance2D = 1 max ((_radar distance2D _target) / 1000); // km
private _distance3D = 1 max ((_radar distance _target) / 1000); // km
private _rangeRatio = _radarRange / _distance3D;

private _detectingPower = _radarCrossSection * _rangeRatio ^ 4; // 1 for 5m^2 RCS aircraft at maximum radar range, high altitude

private _altAGLS = getPos _target select 2;
private _altASL = getPosASL _target select 2;
private _altRadar = 1 max (_altAGLS min _altASL);

private _volumeClutter = GVAR(volumeClutterFactor) * rain * _rangeRatio ^ 2;
private _groundClutter = 0; // GVAR(groundClutterFactor) * (1 / _altRadar) * _rangeRatio ^ 2;
private _radarClutter = 1 + _volumeClutter * _vClutterMultiplier + _groundClutter * _gClutterMultiplier; // 1 for background noise

private _radarDetection = _detectingPower / _radarClutter;

_radarDetection
