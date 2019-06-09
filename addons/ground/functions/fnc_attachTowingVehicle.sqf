#include "script_component.hpp"

private _car = _this select 0;

if !(_car getVariable [QGVAR(hasTowBarDeployed), false]) exitWith {};

private _towArray = [_car] call FUNC(getTowTarget);
private _plane = _towArray select 0;
private _towBarCenterPos = _towArray select 1;
private _attachPos = _towArray select 2;
private _rotateCenter = _towArray select 3;

if (isNull _plane) exitWith {};

private _towBar = _car getVariable [QGVAR(towBarObject), objNull];

player setVariable [QGVAR(towVehicle), _car, true];
_car setVariable [QGVAR(isTowingPlane), true, true];
_car setVariable [QGVAR(towingTarget), _plane, true];
_car setVariable [QGVAR(towingOwner), owner _plane, true];

_car setVariable [QGVAR(offsetOldArray), [], true];
_car setVariable [QGVAR(posBarOld), AGLtoASL (_car modelToWorld _towBarCenterPos), true];
_car setVariable [QGVAR(towingPosRelCar), _towBarCenterPos, true];
_car setVariable [QGVAR(towingPosRelPlane), _attachPos, true];
_car setVariable [QGVAR(towingRotateCenter), _rotateCenter, true];
_car setVariable [QGVAR(towingTimeOld), time, true];
_car setVariable [QGVAR(towingFrameOld), diag_frameNo, true];

_plane allowDamage false;
_car disableCollisionWith _plane;
_towBar disableCollisionWith _plane;
if !(local _plane) then {
	[_plane, false] remoteExec ["allowDamage", _plane];
	[_car, _plane] remoteExec ["disableCollisionWith", _plane];
	[_towBar, _plane] remoteExec ["disableCollisionWith", _plane];
};

private _eventID = addMissionEventHandler ["EachFrame", {[] call FUNC(eachFrameHandlerTow)}];
_car setVariable [QGVAR(towingEvent), _eventID, true];
