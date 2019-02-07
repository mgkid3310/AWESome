private _car = _this select 0;

private _eventID = _car getVariable ["awesome_towingEvent", 0];
private _plane = _car getVariable ["awesome_towingTarget", objNull];
removeMissionEventHandler ["EachFrame", _eventID];

private _towBar = _car getVariable ["awesome_towBarObject", objNull];
_plane allowDamage true;
_car enableCollisionWith _plane;
_towBar enableCollisionWith _plane;
if !(local _plane) then {
    [_plane, true] remoteExec ["allowDamage", _plane];
    [_car, _plane] remoteExec ["enableCollisionWith", _plane];
    [_towBar, _plane] remoteExec ["enableCollisionWith", _plane];
};

_car setVariable ["awesome_towingEvent", nil];
_car setVariable ["awesome_isTowingPlane", false];
_car setVariable ["awesome_towingTarget", nil];

_car setVariable ["awesome_offsetOldArray", nil];
_car setVariable ["awesome_posBarOld", nil];
_car setVariable ["awesome_towingPosRelCar", nil];
_car setVariable ["awesome_towingPosRelPlane", nil];
_car setVariable ["awesome_towingRotateCenter", nil];
_car setVariable ["awesome_towingTimeOld", nil];
_car setVariable ["awesome_towingFrameOld", nil];

player setVariable ["awesome_towVehicle", nil];
