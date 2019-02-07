private _car = player getVariable ["awesome_towVehicle", objNull];
if (isNull _car) exitWith {};
if !(_car getVariable ["awesome_isTowingPlane", false]) exitWith {};

private _plane = _car getVariable ["awesome_towingTarget", objNull];
if (isNull _plane) exitWith {};

if !((alive _car) && (alive _plane)) exitWith {[_car] call awesome_ground_fnc_detachTowingVehicle};

if (speed _car > awesome_ground_maxSpeedFoward) then {
    _car setVelocity (velocity _car vectorMultiply (awesome_ground_maxSpeedFoward / (abs speed _car)));
};
if (speed _car < (-1 * awesome_ground_maxSpeedReverse)) then {
    _car setVelocity (velocity _car vectorMultiply (awesome_ground_maxSpeedReverse / (abs speed _car)));
};

private _posCarNow = getPosASL _car;
private _posPlaneNow = getPosASL _plane;

private _towBar = _car getVariable ["awesome_towBarObject", objNull];
private _ownerOld = _car getVariable ["awesome_towingOwner", owner _plane];
if !(_ownerOld isEqualTo owner _plane) then {
    _plane allowDamage false;
    _car disableCollisionWith _plane;
    _towBar disableCollisionWith _plane;
    if !(local _plane) then {
        [_plane, false] remoteExec ["allowDamage", _plane];
        [_car, _plane] remoteExec ["disableCollisionWith", _plane];
        [_towBar, _plane] remoteExec ["disableCollisionWith", _plane];
    };
    _car setVariable ["awesome_towingOwner", owner _plane];
};

private _offsetOldArray = _car getVariable ["awesome_offsetOldArray", []];
private _posBarOld = _car getVariable ["awesome_posBarOld", []];
private _posRelCar = _car getVariable ["awesome_towingPosRelCar", []];
private _posRelPlane = _car getVariable ["awesome_towingPosRelPlane", []];
private _rotateCenter = _car getVariable ["awesome_towingRotateCenter", []];
private _timeOld = _car getVariable ["awesome_towingTimeOld", time];
private _frameOld = _car getVariable ["awesome_towingFrameOld", diag_frameNo];

if (!(time > _timeOld) || (diag_frameNo < (_frameOld + awesome_ground_perFrame))) exitWith {};

private _timeStep = time - _timeOld;
private _offsetVector = (AGLtoASL (_car modelToWorld _posRelCar)) vectorDiff (AGLtoASL (_plane modelToWorld _posRelPlane));

if (vectorMagnitude _offsetVector > 3) exitWith {[_car] call awesome_ground_fnc_detachTowingVehicle};

// base velocity
private _velVector = [0, 0, 0];
if (count _posBarOld > 0) then {
    _velVector = (AGLtoASL (_car modelToWorld _posRelCar)) vectorDiff _posBarOld;
};
private _velBase = _velVector vectorMultiply (1 / _timeStep);

// PID control
private _offsetIntegral = [0, 0, 0];
if (count _offsetOldArray >= awesome_ground_minIntegralItem) then {
    {
        _offsetIntegral = _offsetIntegral vectorAdd _x;
    } forEach _offsetOldArray;
    _offsetIntegral = _offsetIntegral vectorMultiply (1 / (count _offsetOldArray));
};
private _offsetDerivative = [0, 0, 0];
if (count _offsetOldArray > 0) then {
    _offsetDerivative = (_offsetVector vectorDiff (_offsetOldArray select (count _offsetOldArray - 1))) vectorMultiply (1 / _timeStep);
};
private _velTotal = (_velBase vectorMultiply awesome_ground_velBase) vectorAdd (_offsetVector vectorMultiply awesome_ground_Pconst) vectorAdd (_offsetIntegral vectorMultiply awesome_ground_Iconst) vectorAdd (_offsetDerivative vectorMultiply awesome_ground_Dconst);

// process to foward speed & heading
private _vectorDir = AGLtoASL (_car modelToWorld _posRelCar) vectorDiff AGLtoASL (_plane modelToWorld _rotateCenter);
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
if (_isInit || (count _offsetOldArray >= awesome_ground_maxIntegralItem)) then {
    _offsetOldArray deleteAt 0;
};
_offsetOldArray pushBack _offsetVector;
_car setVariable ["awesome_offsetOldArray", _offsetOldArray];
_car setVariable ["awesome_posBarOld", AGLtoASL (_car modelToWorld _posRelCar)];
_car setVariable ["awesome_towingTimeOld", time];
_car setVariable ["awesome_towingFrameOld", diag_frameNo];
