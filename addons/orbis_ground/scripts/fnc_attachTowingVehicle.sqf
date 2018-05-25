private _car = _this select 0;

if !(_car getVariable ["orbis_hasTowBarDeployed", false]) exitWith {false};

private _towBar = _car getVariable ["orbis_towBarObject", objNull];
private _surfaces = lineIntersectsSurfaces [
    getPosASL _car vectorAdd [0.22, 7.63, -1.31],
    getPosASL _car vectorAdd [-0.3, 7.63, -1.31],
    _car,
    _towBar,
    true,
    -1
];
private _objects = _surfaces apply {_x select 3};

private _plane = objNull;
{
    if (_x isKindOf "Plane") exitWith {
        _plane = _x;
    };
} forEach _objects;

if (isNull _plane) exitWith {};

_plane attachTo [_car];

missionNamespace setVariable ["orbis_towVehicle", _car];
_car setVariable ["orbis_isTowingPlane", true];
_car setVariable ["orbis_towingTarget", _plane];
_car setVariable ["orbis_towingPosCarLast", getPosASL _car];
_car setVariable ["orbis_towingPosPlaneLast", getPosASL _plane];
_car setVariable ["orbis_towingDistance", vectorMagnitude (_car worldToModel ASLToAGL getPosASL _plane)];

private _eventID = addMissionEventHandler ["EachFrame", {[] call orbis_ground_fnc_eachFrameHandlerTow}];
_car setVariable ["orbis_towingEvent", _eventID];
