private _vehicle = _this select 0;
private _player = _this select 1;
private _timeOld = _this select 2;
private _aeroConfigs = _this select 3;

// terminate when player isn't in vehicle
if (!(vehicle _player isEqualTo _vehicle) || !(alive _vehicle)) exitWith {};

private _mass = getMass _vehicle;
private _timeStep = time - _timeOld;

private _dragArray = _aeroConfigs select 0;
private _liftArray = _aeroConfigs select 1;
private _performanceArray = _aeroConfigs select 2;

private _speedMax = _performanceArray select 0;
private _speedStall = _performanceArray select 1;

// if time step is 0, skip current step
if !(_timeStep > 0) exitWith {
    _timeOld = time;

    private _frameNo = diag_frameNo;
    waitUntil {diag_frameNo > _frameNo};

    [_vehicle, _player, _timeOld, _aeroConfigs] spawn orbis_aerodynamics_fnc_fixedWingLoop;
};

// get TAS and etc. (use model coordiate system until further notice)
private _modelvelocity = velocityModelSpace _vehicle;
private _modelWind = _vehicle vectorWorldToModel wind;
private _trueAirVelocity = _modelvelocity vectorDiff _modelWind;

// get drag correction
private _dragGround = [_modelvelocity, _dragArray] call orbis_aerodynamics_fnc_getDrag;
private _dragTAS = [_trueAirVelocity, _dragArray] call orbis_aerodynamics_fnc_getDrag;
private _forceDragCorrection = _dragTAS vectorDiff _dragGround;

// get lift correction
private _liftGround = [_modelvelocity, _liftArray, _speedMax] call orbis_aerodynamics_fnc_getlift;
private _liftTAS = [_trueAirVelocity, _liftArray, _speedMax] call orbis_aerodynamics_fnc_getlift;
private _forceLiftCorrection = _liftTAS vectorDiff _liftGround;

// sum up corrections and bring wheel friction into calculation if needed (todo)
private _forceApply = _forceDragCorrection vectorAdd _forceLiftCorrection;
if (isTouchingGround _vehicle) then {
    _forceApply set [0, 0];
    _forceApply set [1, 0];
    _forceApply set [2, (_forceApply select 2) max 0];
};

// get DeltaV needed on world cooridate system and apply it
private _worldDeltaV = _vehicle vectorModeltoWorld (_forceApply vectorMultiply (_timeStep / _mass));
_vehicle setVelocity (velocity _vehicle vectorAdd _worldDeltaV);

// wait a frame then spawn next loop
private _frameNo = diag_frameNo;
waitUntil {diag_frameNo > _frameNo};

[_vehicle, _player, time, _aeroConfigs] spawn orbis_aerodynamics_fnc_fixedWingLoop;
