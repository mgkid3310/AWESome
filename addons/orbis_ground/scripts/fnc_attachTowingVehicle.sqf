private _car = _this select 0;

if !(_car getVariable ["orbis_hasTowBarDeployed", false]) exitWith {false};

private _towBar = getVariable ["orbis_towBarObject", objNull];
private _objects = lineIntersectsSurfaces [
    getPosASL _car vectorAdd [0.22, 7.63, -1.31],
    getPosASL _car vectorAdd [-0.3, 7.63, -1.31],
    _car,
    _towBar,
    true,
    -1,
] apply {_x select 3};

private _plane = objNull;
{
    if (_x isKindOf "Plane") exitWith {
        _plane = _x;
    };
} forEach _objects;

if (isNull _plane) exitWith {};
_car setVariable ["orbis_isTowingPlane", true];
_car setVariable ["orbis_towingTarget", _plane];
