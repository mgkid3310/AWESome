private _car = missionNamespace getVariable ["orbis_towVehicle", objNull];
if (isNull _car) exitWith {};
if !(_car getVariable ["orbis_isTowingPlane", false]) exitWith {};

private _plane = _car getVariable ["orbis_towingTarget", objNull];
if (isNull _plane) exitWith {};

private _posCarNow = getPosASL _car;
private _posPlaneNow = getPosASL _plane;

private _offsetOldArray = _car getVariable ["orbis_offsetOldArray", [[0, 0, 0]]];
private _posRelCar = _car getVariable ["orbis_towingPosRelCar", []];
private _posRelPlane = _car getVariable ["orbis_towingPosRelPlane", []];
private _timeOld = _car getVariable ["orbis_towingTimeOld", time];
private _frameOld = _car getVariable ["orbis_towingFrameOld", diag_frameNo];

if (!(time > _timeOld) || (diag_frameNo < (_frameOld + 2))) exitWith {};

private _timeStep = time - _timeOld;

private _offsetVector = AGLtoASL (_plane modelToWorld _posRelPlane) vectorDiff AGLtoASL (_car modelToWorld _posRelCar);
private _offestIntegral = [0, 0, 0];
{
    _offestIntegral = _offestIntegral vectorAdd _x;
} forEach _offsetOldArray;
_offestIntegral = _offestIntegral vectorMultiply (1 / (count _offsetOldArray));
private _offsetDerivative = (_offsetVector vectorDiff (_offsetOldArray select (count _offsetOldArray - 1))) vectorMultiply (1 / _timeStep);
private _velTotal = (orbis_ground_Pconst * _offsetVector) + (orbis_ground_Iconst * _offestIntegral) + (orbis_ground_Dconst * _offsetDerivative);

private _vectorDir = AGLtoASL (_car modelToWorld _posRelCar) vectorDiff getPosASL _plane;
private _dirTotal = _vectorDir vectorAdd (_velTotal vectorMultiply _timeStep);

private _targetVelFwd = [0, vectorMagnitude _velTotal, 0];
private _targetDir = vectorNormalized _dirTotal;

private _isBackward = acos (_offsetVector vectorCos _targetDir) > 90;
if (_isBackward) then {
    _targetVelFwd = _targetVelFwd vectorMultiply -1;
};

if (vectorMagnitude _offsetVector < 0.01) then {
    _targetVelFwd = [0, 0, 0];
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

if (count _offsetOldArray >= 20) then {
    _offsetOldArray deleteAt 0;
};
_offsetOldArray pushBack _offsetVector;
_car setVariable ["orbis_offsetOldArray", _offsetOldArray];
_car setVariable ["orbis_towingTimeOld", time];
_car setVariable ["orbis_towingFrameOld", diag_frameNo];
