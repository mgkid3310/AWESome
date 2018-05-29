private _car = missionNamespace getVariable ["orbis_towVehicle", objNull];
if (isNull _car) exitWith {};
if !(_car getVariable ["orbis_isTowingPlane", false]) exitWith {};

private _plane = _car getVariable ["orbis_towingTarget", objNull];
if (isNull _plane) exitWith {};

private _posCar = getPosASL _car;
private _posPlane = getPosASL _plane;
private _posRelCar = _car getVariable ["orbis_towingPosRelCar", []];
private _posRelPlane = _car getVariable ["orbis_towingPosRelPlane", []];
private _posCarOld = _car getVariable ["orbis_towingPosCarLast", []];
private _posPlaneOld = _car getVariable ["orbis_towingPosPlaneLast", []];

if (((count _posRelCar) != 3) || ((count _posRelPlane) != 3) || ((count _posCarOld) != 3) || ((count _posPlaneOld) != 3)) exitWith {};

private _targetVel = [];
private _targetHeading = ;
private _targetVelFwd = [0, vectorMagnitude _targetVel, 0];

if (local _plane) then {
    _plane setDir _targetHeading;
    _plane setVelocity _targetVelFwd;
} else {
    [_plane, _targetHeading] remoteExec ["setDir", _plane];
    [_plane, _targetVel] remoteExec ["setVelocity", _plane];
};

_car setVariable ["orbis_towingPosCarLast", getPosASL _car];
_car setVariable ["orbis_towingPosPlaneLast", getPosASL _plane];
