#include "script_component.hpp"

private _car = _this select 0;

private _eventID = _car getVariable [QGVAR(towingEvent), 0];
private _plane = _car getVariable [QGVAR(towingTarget), objNull];
removeMissionEventHandler ["EachFrame", _eventID];

private _towBar = _car getVariable [QGVAR(towBarObject), objNull];
_plane allowDamage true;
_car enableCollisionWith _plane;
_towBar enableCollisionWith _plane;
if !(local _plane) then {
	[_plane, true] remoteExec ["allowDamage", _plane];
	[_car, _plane] remoteExec ["enableCollisionWith", _plane];
	[_towBar, _plane] remoteExec ["enableCollisionWith", _plane];
};

_car setVariable [QGVAR(towingEvent), nil];
_car setVariable [QGVAR(isTowingPlane), false];
_car setVariable [QGVAR(towingTarget), nil];

_car setVariable [QGVAR(offsetOldArray), nil];
_car setVariable [QGVAR(posBarOld), nil];
_car setVariable [QGVAR(towingPosRelCar), nil];
_car setVariable [QGVAR(towingPosRelPlane), nil];
_car setVariable [QGVAR(towingRotateCenter), nil];
_car setVariable [QGVAR(towingTimeOld), nil];
_car setVariable [QGVAR(towingFrameOld), nil];

player setVariable [QGVAR(towVehicle), nil];
