private _car = _this select 0;

if (!(_car getVariable ["orbis_hasTowBarDeployed", false]) || (_car getVariable ["orbis_isTowingPlane", false])) exitWith {false};

private _target = objNull;
private _availablePlanes = _car nearEntities ["Plane", 100];
private _availableHelis = (_car nearEntities ["Helicopter", 100]) select {0 < count getArray (configFile >> "CfgVehicles" >> (typeOf _x) >> "driveOnComponent")};
private _availableTargets = _availablePlanes + _availableHelis;

private _rotateCenter = [0, 0, 0];

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

if (isNull _target) then {
    {
        private _vehicle = _x;
        private _wheelPos = (getArray (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "driveOnComponent")) apply {_vehicle selectionPosition _x};
        private _wheelPosSorted = [_wheelPos, [], {_x select 1}, "DESCEND"] call BIS_fnc_sortBy;
        if (count _wheelPosSorted > 0) then {
            private _frontWheelPos = _wheelPosSorted select 0;
            private _rearWheelPos = _wheelPosSorted select (count _wheelPosSorted - 1);
            private _distanceFront = (AGLToASL (_vehicle modelToWorld _frontWheelPos)) distance2D (AGLToASL (_car modelToWorld _checkCenter));
            private _distanceRear = (AGLToASL (_vehicle modelToWorld _rearWheelPos)) distance2D (AGLToASL (_car modelToWorld _checkCenter));

            if (_distanceFront < 1) exitWith {
                _target = _vehicle;
                _attachPos = _frontWheelPos;
                private _rearWheels = _wheelPosSorted select {(_x distance _frontWheelPos) > 0.3};
                private _rotateCenter = [0, 0, 0];
                {
                    _rotateCenter = _rotateCenter vectorAdd _x;
                } forEach _rearWheels;
                _rotateCenter = _rotateCenter vectorMultiply (1 / (1 max (count _rearWheels)));
            };

            if (_distanceRear < 1) exitWith {
                _target = _vehicle;
                _attachPos = _rearWheelPos;
                private _otherWheels = _wheelPosSorted select {(_x distance _rearWheelPos) > 0.3};
                private _rotateCenter = [0, 0, 0];
                {
                    _rotateCenter = _rotateCenter vectorAdd _x;
                } forEach _otherWheels;
                _rotateCenter = _rotateCenter vectorMultiply (1 / (1 max (count _rearWheels)));
            };
        };
    } forEach _availableTargets;
};

[_target, _checkCenter, _attachPos, _rotateCenter]
