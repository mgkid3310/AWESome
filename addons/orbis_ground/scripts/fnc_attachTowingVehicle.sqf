private _car = _this select 0;

if !(_car getVariable ["orbis_hasTowBarDeployed", false]) exitWith {};

private _checkStart = getArray (configFile >> "CfgVehicles" >> (typeOf _car) >> "orbis_towBarCheckStart");
private _checkEnd = getArray (configFile >> "CfgVehicles" >> (typeOf _car) >> "orbis_towBarCheckEnd");
private _towBar = _car getVariable ["orbis_towBarObject", objNull];
private _surfaces = lineIntersectsSurfaces [
    AGLToASL (_car modelToWorld _checkStart),
    AGLToASL (_car modelToWorld _checkEnd),
    _car,
    _towBar,
    true,
    -1
];
private _objects = _surfaces apply {_x select 3};

private ["_plane", "_posIntersect"];
{
    if (_x isKindOf "Plane") exitWith {
        _plane = _x;
        _posIntersect = _surfaces select _forEachIndex select 0;
    };
} forEach _objects;

if (isNull _plane) exitWith {};

missionNamespace setVariable ["orbis_towVehicle", _car];
_car setVariable ["orbis_isTowingPlane", true];
_car setVariable ["orbis_towingTarget", _plane];

_car setVariable ["orbis_offsetOldArray", []];
_car setVariable ["orbis_towingPosRelPlane", _plane worldToModel ASLToAGL _posIntersect];
_car setVariable ["orbis_towingPosRelCar", _car worldToModel ASLToAGL _posIntersect];
_car setVariable ["orbis_towingTimeOld", time];
_car setVariable ["orbis_towingFrameOld", diag_frameNo];

_car disableCollisionWith _plane;
_towBar disableCollisionWith _plane;

private _eventID = addMissionEventHandler ["EachFrame", {[] call orbis_ground_fnc_eachFrameHandlerTow}];
_car setVariable ["orbis_towingEvent", _eventID];
