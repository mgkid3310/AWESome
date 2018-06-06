private _car = missionNamespace getVariable ["orbis_towVehicle", objNull];
if (isNull _car) exitWith {};
if !(_car getVariable ["orbis_isTowingPlane", false]) exitWith {};

private _plane = _car getVariable ["orbis_towingTarget", objNull];
if (isNull _plane) exitWith {};

private _posCarNow = getPosASL _car;
private _posPlaneNow = getPosASL _plane;

private _offsetOldArray = _car getVariable ["orbis_offsetOldArray", []];
private _posBarOld = _car getVariable ["orbis_posBarOld", []];
private _posRelCar = _car getVariable ["orbis_towingPosRelCar", []];
private _posRelPlane = _car getVariable ["orbis_towingPosRelPlane", []];
private _timeOld = _car getVariable ["orbis_towingTimeOld", time];
private _frameOld = _car getVariable ["orbis_towingFrameOld", diag_frameNo];

if (!(time > _timeOld) || (diag_frameNo < (_frameOld + orbis_ground_perFrame))) exitWith {};

private _timeStep = time - _timeOld;

private _velVector = [0, 0, 0];
if (count _posBarOld > 0) then {
    _velVector = (AGLtoASL (_car modelToWorld _posRelCar)) vectorDiff _posBarOld;
};
private _velBase = _velVector vectorMultiply (1 / _timeStep);

private _offsetVector = (AGLtoASL (_car modelToWorld _posRelCar)) vectorDiff (AGLtoASL (_plane modelToWorld _posRelPlane));
private _offsetIntegral = [0, 0, 0];
if (count _offsetOldArray >= orbis_ground_minIntegralItem) then {
    {
        _offsetIntegral = _offsetIntegral vectorAdd _x;
    } forEach _offsetOldArray;
};
_offsetIntegral = _offsetIntegral vectorMultiply (1 / (count _offsetOldArray));
private _offsetDerivative = (_offsetVector vectorDiff (_offsetOldArray select (count _offsetOldArray - 1))) vectorMultiply (1 / _timeStep);
private _velTotal = (_velBase vectorMultiply orbis_ground_velBase) vectorAdd (_offsetVector vectorMultiply orbis_ground_Pconst) vectorAdd (_offsetIntegral vectorMultiply orbis_ground_Iconst) vectorAdd (_offsetDerivative vectorMultiply orbis_ground_Dconst);

private _vectorDir = AGLtoASL (_car modelToWorld _posRelCar) vectorDiff getPosASL _plane;
private _dirTotal = _vectorDir vectorAdd (_velTotal vectorMultiply _timeStep);

private _targetVelFwd = [0, vectorMagnitude _velTotal, 0];
private _targetDir = vectorNormalized _dirTotal;

private _isBackward = acos (_velTotal vectorCos _targetDir) > 90;
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

if (_isInit || (count _offsetOldArray >= orbis_ground_maxIntegralItem)) then {
    _offsetOldArray deleteAt 0;
};
_offsetOldArray pushBack _offsetVector;
_car setVariable ["orbis_offsetOldArray", _offsetOldArray];
_car setVariable ["orbis_posBarOld", AGLtoASL (_car modelToWorld _posRelCar)];
_car setVariable ["orbis_towingTimeOld", time];
_car setVariable ["orbis_towingFrameOld", diag_frameNo];
