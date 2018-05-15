private _vehicle = _this select 0;
private _player = _this select 1;
private _timeOld = _this select 2;

private _timeStep = time - _timeOld;
if !(_timeStep > 0) exitWith {};

private _aeroConfigs = _vehicle getVariable ["orbis_aerodynamics_aeroConfig", false];
if !(_aeroConfigs isEqualType []) then {
    _aeroConfigs = [_vehicle] call orbis_aerodynamics_fnc_getAeroConfig;
    _vehicle setVariable ["orbis_aerodynamics_aeroConfig", _aeroConfigs];
};

private _mass = getMass _vehicle;

private _dragArray = _aeroConfigs select 0;
private _liftArray = _aeroConfigs select 1;
private _performanceArray = _aeroConfigs select 2;

private _speedMax = _performanceArray select 0;
private _speedStall = _performanceArray select 1;

// get TAS and etc. (use model coordiate system until further notice)
private _modelvelocity = velocityModelSpace _vehicle;
private _modelWind = _vehicle vectorWorldToModel wind;
private _trueAirVelocity = _modelvelocity vectorDiff _modelWind;

// get drag correction
private _dragGround = [_modelvelocity, _dragArray] call orbis_aerodynamics_fnc_getDrag;
private _dragTAS = [_trueAirVelocity, _dragArray] call orbis_aerodynamics_fnc_getDrag;
private _forceDragCorrection = _dragTAS vectorDiff _dragGround;

// get lift correction
private _liftGround = [_modelvelocity, _liftArray, _speedMax, _mass] call orbis_aerodynamics_fnc_getlift;
private _liftTAS = [_trueAirVelocity, _liftArray, _speedMax, _mass] call orbis_aerodynamics_fnc_getlift;
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
