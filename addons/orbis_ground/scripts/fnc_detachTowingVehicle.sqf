private _car = _this select 0;

private _eventID = getVariable ["orbis_towingEvent", 0];
private _plane = getVariable ["orbis_towingTarget", objNull];
removeMissionEventHandler ["EachFrame", _eventID];
detach _plane;

_car setVariable ["orbis_towingEvent", 0];
_car setVariable ["orbis_isTowingPlane", false];
_car setVariable ["orbis_towingTarget", objNull];
missionNamespace setVariable ["orbis_towVehicle", objNull];
