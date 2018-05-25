private _car = _this select 0;

if (!(_car getVariable ["orbis_hasTowBarDeployed", false]) || (_car getVariable ["orbis_isTowingPlane", false])) exitWith {false};

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

private _return = false;
{
    if (_x isKindOf "Plane") exitWith {
        _return = true;
    };
} forEach _objects;

_return
