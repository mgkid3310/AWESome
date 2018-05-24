private _car = _this select 0;

if (!(_car getVariable ["orbis_hasTowBarDeployed", false]) || (_car getVariable ["orbis_isTowingPlane", false])) exitWith {false};

private _towBar = _car getVariable ["orbis_towBarObject", objNull];
private _objects = lineIntersectsSurfaces [
    getPosASL _car vectorAdd [0.22, 7.63, -1.31],
    getPosASL _car vectorAdd [-0.3, 7.63, -1.31],
    _car,
    _towBar,
    true,
    -1,
] apply {_x select 3};

{
    if (_x isKindOf "Plane") exitWith {true};
} forEach _objects;

false
