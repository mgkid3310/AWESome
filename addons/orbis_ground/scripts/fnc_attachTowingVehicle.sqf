private _car = _this select 0;

if !(_car getVariable ["orbis_hasTowBarDeployed", false]) exitWith {};

private _towArray = [_car] call orbis_ground_fnc_getTowTarget;
private _plane = _towArray select 0;
private _towBarCenterPos = _towArray select 1;
private _attachPos = _towArray select 2;

if (isNull _plane) exitWith {};

private _wheelPos = (getArray (configFile >> "CfgVehicles" >> (typeOf _plane) >> "driveOnComponent")) apply {_plane selectionPosition _x};
private _wheelPosSorted = [_wheelPos, [], {_x select 1}, "DESCEND"] call BIS_fnc_sortBy;
private _frontWheelPos = _wheelPosSorted select 0;

private _rearWheels = _wheelPosSorted select {(_x distance _frontWheelPos) > 0.3};
private _rotateCenter = [0, 0, 0];
{
    _rotateCenter = _rotateCenter vectorAdd _x;
} forEach _rearWheels;
_rotateCenter = _rotateCenter vectorMultiply (1 / (1 max (count _rearWheels)));

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
