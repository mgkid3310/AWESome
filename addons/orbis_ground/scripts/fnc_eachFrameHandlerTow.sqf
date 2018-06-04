private _car = missionNamespace getVariable ["orbis_towVehicle", objNull];
if (isNull _car) exitWith {};
if !(_car getVariable ["orbis_isTowingPlane", false]) exitWith {};

private _plane = _car getVariable ["orbis_towingTarget", objNull];
if (isNull _plane) exitWith {};

private _posCarNow = getPosASL _car;
private _posPlaneNow = getPosASL _plane;

private _posCarOld = _car getVariable ["orbis_towingPosCarOld", []];
private _posPlaneOld = _car getVariable ["orbis_towingPosPlaneOld", []];
private _posBarOld = _car getVariable ["orbis_towingPosBarOld", []];
private _planeDirOld = _car getVariable ["orbis_towingDirPlaneOld", []];

private _distance = _car getVariable ["orbis_towingDistance", 0];
private _posRelCar = _car getVariable ["orbis_towingPosRelCar", []];
private _timeOld = _car getVariable ["orbis_towingTimeOld", time];
private _frameOld = _car getVariable ["orbis_towingFrameOld", diag_frameNo];

if (!(time > _timeOld) || (diag_frameNo < (_frameOld + 4))) exitWith {};

private _posBarNow = AGLToASL (_car modelToWorld _posRelCar);
private _timeStep = time - _timeOld;

private _vectorDir = (_posBarNow vectorDiff _posBarOld) vectorAdd (_planeDirOld vectorMultiply _distance);
private _vectorOffset = _vectorDir vectorMultiply (((vectorMagnitude _vectorDir) - _distance) / (vectorMagnitude _vectorDir));

if (vectorMagnitude _vectorOffset < 0.01) exitWith {};

private _velBase = _vectorOffset vectorMultiply (1 / _timeStep);

private _error = (_posBarOld vectorDiff _posPlaneOld) vectorDiff (_planeDirOld vectorMultiply _distance);
private _velProportional = _error vectorMultiply -1;

private _velTotal = _velBase vectorAdd _velProportional;
private _targetDir = vectorNormalized (_vectorDir + _velProportional);
private _targetVelFwd = [0, vectorMagnitude _velTotal, 0];

private _isBackward = acos (_velTotal vectorCos _targetDir) > 90;
if !(_isBackward) then {
    _targetDir = _targetDir vectorMultiply -1;
    _targetVelFwd = _targetVelFwd vectorMultiply -1;
};

if (local _plane) then {
    _plane setVelocityModelSpace _targetVelFwd;
    _plane setVectorDir _targetDir;
    _plane setVelocityModelSpace _targetVelFwd;
    // _plane setPos getPos _plane;
} else {
    [_plane, _targetVelFwd] remoteExec ["setVelocityModelSpace", _plane];
    [_plane, _targetDir] remoteExec ["setVectorDir", _plane];
    [_plane, _targetVelFwd] remoteExec ["setVelocityModelSpace", _plane];
    // [_plane, getPos _plane] remoteExec ["setPos", _plane];
};

_car setVariable ["orbis_towingPosCarOld", getPosASL _car];
_car setVariable ["orbis_towingPosPlaneOld", getPosASL _plane];
_car setVariable ["orbis_towingPosBarOld", _posBarNow];
_car setVariable ["orbis_towingDirPlaneOld", _targetDir];

_car setVariable ["orbis_towingTimeOld", time];
_car setVariable ["orbis_towingFrameOld", diag_frameNo];
