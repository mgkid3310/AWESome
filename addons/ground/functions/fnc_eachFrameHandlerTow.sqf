#include "script_component.hpp"

private _car = player getVariable [QGVAR(towVehicle), objNull];
if (isNull _car) exitWith {};
if !(_car getVariable [QGVAR(isTowingPlane), false]) exitWith {};

private _plane = _car getVariable [QGVAR(towingTarget), objNull];
if (isNull _plane) exitWith {};

if !((alive _car) && (alive _plane)) exitWith {[_car] call FUNC(detachTowingVehicle)};

if (speed _car > GVAR(maxSpeedFoward)) then {
	_car setVelocity (velocity _car vectorMultiply (GVAR(maxSpeedFoward) / (abs speed _car)));
};
if (speed _car < (-1 * GVAR(maxSpeedReverse))) then {
	_car setVelocity (velocity _car vectorMultiply (GVAR(maxSpeedReverse) / (abs speed _car)));
};

private _posCarNow = getPosASL _car;
private _posPlaneNow = getPosASL _plane;

private _towBar = _car getVariable [QGVAR(towBarObject), objNull];
private _ownerOld = _car getVariable [QGVAR(towingOwner), owner _plane];
if !(_ownerOld isEqualTo owner _plane) then {
	_plane allowDamage false;
	_car disableCollisionWith _plane;
	_towBar disableCollisionWith _plane;
	if !(local _plane) then {
		[_plane, false] remoteExec ["allowDamage", _plane];
		[_car, _plane] remoteExec ["disableCollisionWith", _plane];
		[_towBar, _plane] remoteExec ["disableCollisionWith", _plane];
	};
	_car setVariable [QGVAR(towingOwner), owner _plane];
};

private _offsetOldArray = _car getVariable [QGVAR(offsetOldArray), []];
private _posBarOld = _car getVariable [QGVAR(posBarOld), []];
private _posRelCar = _car getVariable [QGVAR(towingPosRelCar), []];
private _posRelPlane = _car getVariable [QGVAR(towingPosRelPlane), []];
private _rotateCenter = _car getVariable [QGVAR(towingRotateCenter), []];
private _timeOld = _car getVariable [QGVAR(towingTimeOld), time];
private _frameOld = _car getVariable [QGVAR(towingFrameOld), diag_frameNo];

if (!(time > _timeOld) || (diag_frameNo < (_frameOld + GVAR(perFrame)))) exitWith {};

private _timeStep = time - _timeOld;
private _offsetVector = (AGLToASL (_car modelToWorld _posRelCar)) vectorDiff (AGLToASL (_plane modelToWorld _posRelPlane));

if (vectorMagnitude _offsetVector > 3) exitWith {[_car] call FUNC(detachTowingVehicle)};

// base velocity
private _velVector = [0, 0, 0];
if (count _posBarOld > 0) then {
	_velVector = (AGLToASL (_car modelToWorld _posRelCar)) vectorDiff _posBarOld;
};
private _velBase = _velVector vectorMultiply (1 / _timeStep);

// PID control
private _offsetIntegral = [0, 0, 0];
if (count _offsetOldArray >= GVAR(minIntegralItem)) then {
	{
		_offsetIntegral = _offsetIntegral vectorAdd _x;
	} forEach _offsetOldArray;
	_offsetIntegral = _offsetIntegral vectorMultiply (1 / (count _offsetOldArray));
};
private _offsetDerivative = [0, 0, 0];
if (count _offsetOldArray > 0) then {
	_offsetDerivative = (_offsetVector vectorDiff (_offsetOldArray select -1)) vectorMultiply (1 / _timeStep);
};
private _velTotal = (_velBase vectorMultiply GVAR(velBase)) vectorAdd (_offsetVector vectorMultiply GVAR(Pconst)) vectorAdd (_offsetIntegral vectorMultiply GVAR(Iconst)) vectorAdd (_offsetDerivative vectorMultiply GVAR(Dconst));

// process to foward speed & heading
private _vectorDir = AGLToASL (_car modelToWorld _posRelCar) vectorDiff AGLToASL (_plane modelToWorld _rotateCenter);
private _dirTotal = _vectorDir vectorAdd (_velTotal vectorMultiply _timeStep);

private _targetVelFwd = [0, vectorMagnitude _velTotal, 0];
private _targetDir = vectorNormalized _dirTotal;
private _targetHeading = [0, 0, 0] getDir _targetDir;

private _isBackward = acos (_velTotal vectorCos _targetDir) > 90;
if (_isBackward) then {
	_targetVelFwd = _targetVelFwd vectorMultiply -1;
};

private _isTowingRear = ((_posRelPlane vectorDiff _rotateCenter) select 1) < 0;
if (_isTowingRear) then {
	_targetVelFwd = _targetVelFwd vectorMultiply -1;
	_targetHeading = (_targetHeading + 180) % 360;
};

if (vectorMagnitude _offsetVector < 0.01) then {
	_targetVelFwd = [0, 0, 0];
};

// apply changes
if (local _plane) then {
	_plane setVelocityModelSpace _targetVelFwd;
	_plane setDir _targetHeading;
	_plane setVelocityModelSpace _targetVelFwd;
	// _plane setPos getPos _plane;
} else {
	[_plane, _targetVelFwd] remoteExec ["setVelocityModelSpace", _plane];
	[_plane, _targetHeading] remoteExec ["setDir", _plane];
	[_plane, _targetVelFwd] remoteExec ["setVelocityModelSpace", _plane];
	// [_plane, getPos _plane] remoteExec ["setPos", _plane];
};

// save data for next run
if (_isInit || (count _offsetOldArray >= GVAR(maxIntegralItem))) then {
	_offsetOldArray deleteAt 0;
};
_offsetOldArray pushBack _offsetVector;
_car setVariable [QGVAR(offsetOldArray), _offsetOldArray];
_car setVariable [QGVAR(posBarOld), AGLToASL (_car modelToWorld _posRelCar)];
_car setVariable [QGVAR(towingTimeOld), time];
_car setVariable [QGVAR(towingFrameOld), diag_frameNo];
