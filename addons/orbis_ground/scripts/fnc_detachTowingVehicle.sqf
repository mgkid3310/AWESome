private _car = _this select 0;

private _eventID = _car getVariable ["orbis_towingEvent", 0];
private _plane = _car getVariable ["orbis_towingTarget", objNull];
removeMissionEventHandler ["EachFrame", _eventID];

_car setVariable ["orbis_towingEvent", nil];
_car setVariable ["orbis_isTowingPlane", false];
_car setVariable ["orbis_towingTarget", nil];

_car setVariable ["orbis_towingPosCarOld", nil];
_car setVariable ["orbis_towingPosPlaneOld", nil];
_car setVariable ["orbis_towingPosBarOld", nil];
_car setVariable ["orbis_towingDirPlaneOld", nil];

_car setVariable ["orbis_towingDistance", nil];
_car setVariable ["orbis_towingPosRelCar", nil];
_car setVariable ["orbis_towingTimeOld", nil];
_car setVariable ["orbis_towingFrameOld", nil];

missionNamespace setVariable ["orbis_towVehicle", objNull];
