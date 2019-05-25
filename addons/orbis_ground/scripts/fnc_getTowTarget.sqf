private _car = _this select 0;

if (!(_car getVariable ["orbis_hasTowBarDeployed", false]) || (_car getVariable ["orbis_isTowingPlane", false])) exitWith {
	[objNull, [0, 0, 0], [0, 0, 0], [0, 0, 0]]
};

private ["_vehicle", "_wheelPos", "_wheelPosSorted", "_frontWheelPos", "_rearWheelPos", "_distanceFront", "_distanceRear", "_otherWheels"];
private ["_towBar", "_surfaces", "_objects"];

private _target = objNull;
private _availablePlanes = _car nearEntities ["Plane", 100];
private _availableHelis = (_car nearEntities ["Helicopter", 100]) select {0 < count getArray (configFile >> "CfgVehicles" >> (typeOf _x) >> "driveOnComponent")};
private _availableTargets = _availablePlanes + _availableHelis;

private _checkStart = getArray (configFile >> "CfgVehicles" >> (typeOf _car) >> "orbis_towBarCheckStart");
private _checkEnd = getArray (configFile >> "CfgVehicles" >> (typeOf _car) >> "orbis_towBarCheckEnd");
private _checkCenter = (_checkStart vectorAdd _checkEnd) vectorMultiply 0.5;

private _attachPos = [];
private _rotateCenter = [0, 0, 0];

{
	_vehicle = _x;
	_wheelPos = (getArray (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "driveOnComponent")) apply {_vehicle selectionPosition _x};
	if (count _wheelPos > 0) then {
		_wheelPosSorted = [_wheelPos, [], {_x select 1}, "DESCEND"] call BIS_fnc_sortBy;
		_frontWheelPos = _wheelPosSorted select 0;
		_rearWheelPos = _wheelPosSorted select (count _wheelPosSorted - 1);
		_distanceFront = (AGLToASL (_vehicle modelToWorld _frontWheelPos)) distance2D (AGLToASL (_car modelToWorld _checkCenter));
		_distanceRear = (AGLToASL (_vehicle modelToWorld _rearWheelPos)) distance2D (AGLToASL (_car modelToWorld _checkCenter));

		if (_distanceFront < 1) exitWith {
			_target = _vehicle;
			_attachPos = _frontWheelPos;
			_otherWheels = _wheelPosSorted select {(_x distance _frontWheelPos) > 0.3};
			_rotateCenter = [0, 0, 0];
			{
				_rotateCenter = _rotateCenter vectorAdd _x;
			} forEach _otherWheels;
			_rotateCenter = _rotateCenter vectorMultiply (1 / (1 max (count _otherWheels)));
		};

		if (_distanceRear < 1) exitWith {
			_target = _vehicle;
			_attachPos = _rearWheelPos;
			_otherWheels = _wheelPosSorted select {(_x distance _rearWheelPos) > 0.3};
			_rotateCenter = [0, 0, 0];
			{
				_rotateCenter = _rotateCenter vectorAdd _x;
			} forEach _otherWheels;
			_rotateCenter = _rotateCenter vectorMultiply (1 / (1 max (count _otherWheels)));
		};
	};
} forEach _availableTargets;

if (isNull _target) then {
	_towBar = _car getVariable ["orbis_towBarObject", objNull];
	_surfaces = lineIntersectsSurfaces [
		AGLToASL (_car modelToWorld _checkStart),
		AGLToASL (_car modelToWorld _checkEnd),
		_car,
		_towBar,
		true,
		-1
	];
	_objects = _surfaces apply {_x select 3};

	{
		if (_x in _availableTargets) exitWith {
			_target = _x;
			_attachPos = _x worldToModel ASLToAGL (_surfaces select _forEachIndex select 0);
		};
	} forEach _objects;
};

_attachPos set [2, _target worldToModel (_car modelToWorld _checkCenter) select 2];

[_target, _checkCenter, _attachPos, _rotateCenter]
