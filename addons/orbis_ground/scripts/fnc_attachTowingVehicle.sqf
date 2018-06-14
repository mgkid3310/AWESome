private _car = _this select 0;

if !(_car getVariable ["orbis_hasTowBarDeployed", false]) exitWith {};

private _towArray = [_car] call orbis_ground_fnc_getTowTarget;
private _plane = _towArray select 0;
private _towBarCenterPos = _towArray select 1;
private _attachPos = _towArray select 2;
private _rotateCenter = _towArray select 3;

if (isNull _plane) exitWith {};

player setVariable ["orbis_towVehicle", _car];
_car setVariable ["orbis_isTowingPlane", true];
_car setVariable ["orbis_towingTarget", _plane];

_car setVariable ["orbis_offsetOldArray", []];
_car setVariable ["orbis_posBarOld", AGLtoASL (_car modelToWorld _towBarCenterPos)];
_car setVariable ["orbis_towingPosRelCar", _towBarCenterPos];
_car setVariable ["orbis_towingPosRelPlane", _attachPos];
_car setVariable ["orbis_towingRotateCenter", _rotateCenter];
_car setVariable ["orbis_towingTimeOld", time];
_car setVariable ["orbis_towingFrameOld", diag_frameNo];

_car disableCollisionWith _plane;
_towBar disableCollisionWith _plane;
if !(local _plane) then {
    [_car, _plane] remoteExec ["disableCollisionWith", _plane];
    [_towBar, _plane] remoteExec ["disableCollisionWith", _plane];
};

private _eventID = addMissionEventHandler ["EachFrame", {[] call orbis_ground_fnc_eachFrameHandlerTow}];
_car setVariable ["orbis_towingEvent", _eventID];
