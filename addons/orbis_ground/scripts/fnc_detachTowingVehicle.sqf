private _car = _this select 0;

private _eventID = _car getVariable ["orbis_towingEvent", 0];
private _plane = _car getVariable ["orbis_towingTarget", objNull];
removeMissionEventHandler ["EachFrame", _eventID];

_car setVariable ["orbis_towingEvent", nil];
_car setVariable ["orbis_isTowingPlane", false];
_car setVariable ["orbis_towingTarget", nil];

_car setVariable ["orbis_offsetOldArray", nil];
_car setVariable ["orbis_towingPosRelPlane", nil];
_car setVariable ["orbis_towingPosRelCar", nil];
_car setVariable ["orbis_towingTimeOld", nil];
_car setVariable ["orbis_towingFrameOld", nil];

missionNamespace setVariable ["orbis_towVehicle", nil];
