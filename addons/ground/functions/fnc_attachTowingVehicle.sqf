private _car = _this select 0;

if !(_car getVariable ["awesome_hasTowBarDeployed", false]) exitWith {};

private _towArray = [_car] call awesome_ground_fnc_getTowTarget;
private _plane = _towArray select 0;
private _towBarCenterPos = _towArray select 1;
private _attachPos = _towArray select 2;
private _rotateCenter = _towArray select 3;

if (isNull _plane) exitWith {};

private _towBar = _car getVariable ["awesome_towBarObject", objNull];

player setVariable ["awesome_towVehicle", _car];
_car setVariable ["awesome_isTowingPlane", true];
_car setVariable ["awesome_towingTarget", _plane];
_car setVariable ["awesome_towingOwner", owner _plane];

_car setVariable ["awesome_offsetOldArray", []];
_car setVariable ["awesome_posBarOld", AGLtoASL (_car modelToWorld _towBarCenterPos)];
_car setVariable ["awesome_towingPosRelCar", _towBarCenterPos];
_car setVariable ["awesome_towingPosRelPlane", _attachPos];
_car setVariable ["awesome_towingRotateCenter", _rotateCenter];
_car setVariable ["awesome_towingTimeOld", time];
_car setVariable ["awesome_towingFrameOld", diag_frameNo];

_plane allowDamage false;
_car disableCollisionWith _plane;
_towBar disableCollisionWith _plane;
if !(local _plane) then {
    [_plane, false] remoteExec ["allowDamage", _plane];
    [_car, _plane] remoteExec ["disableCollisionWith", _plane];
    [_towBar, _plane] remoteExec ["disableCollisionWith", _plane];
};

private _eventID = addMissionEventHandler ["EachFrame", {[] call awesome_ground_fnc_eachFrameHandlerTow}];
_car setVariable ["awesome_towingEvent", _eventID];
