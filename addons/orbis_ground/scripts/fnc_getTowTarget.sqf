private _car = _this select 0;

if (!(_car getVariable ["orbis_hasTowBarDeployed", false]) || (_car getVariable ["orbis_isTowingPlane", false])) exitWith {false};

private _target = objNull;
private _availableTargets = _car nearEntities ["Plane", 100];

private _checkStart = getArray (configFile >> "CfgVehicles" >> (typeOf _car) >> "orbis_towBarCheckStart");
private _checkEnd = getArray (configFile >> "CfgVehicles" >> (typeOf _car) >> "orbis_towBarCheckEnd");
private _checkCenter = (_checkStart vectorAdd _checkEnd) vectorMultiply 0.5;
private _towBar = _car getVariable ["orbis_towBarObject", objNull];
private _attachPos = [];
private _surfaces = lineIntersectsSurfaces [
    AGLToASL (_car modelToWorld _checkStart),
    AGLToASL (_car modelToWorld _checkEnd),
    _car,
    _towBar,
    true,
    -1
];
private _objects = _surfaces apply {_x select 3};

{
    if (_x in _availableTargets) exitWith {
        _target = _x;
        _attachPos = _x worldToModel ASLToAGL (_surfaces select _forEachIndex select 0);
    };
} forEach _objects;

/* if (isNull _target) then {
    {
        private _vehicle = _x;
        private _wheelPos = (getArray (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "driveOnComponent")) apply {_vehicle selectionPosition _x};
        private _wheelPosSorted = [_wheelPos, [], {_x select 1}, "DESCEND"] call BIS_fnc_sortBy;
        if (count _wheelPosSorted > 0) then {
            private _frontWheelPos = _wheelPosSorted select 0;
            private _distance = (AGLToASL (_vehicle vectorModelToWorld _frontWheelPos)) distance2D (AGLToASL (_car vectorModelToWorld _checkCenter));
            if (_distance < 0.3) exitWith {
                _target = _vehicle;
                _attachPos = _frontWheelPos;
            };
        };
    } forEach _availableTargets;
}; */

[_target, _checkCenter, _attachPos]
