private _vehicle = _this select 0;
private _timeOld = _this select 1;
private _aeroConfigs = _this select 2;

// terminate when player isn't in vehicle
if !(player in _vehicle) exitWith {};

private _mass = getMass _vehicle;
private _timeStep = time - _timeOld;
private _dragArray = _aeroConfigs select 0;

// update timeOld
_timeOld = time;

// if time step is 0, skip current step
if !(_timeStep > 0) exitWith {
    _timeOld = time;

    private _frameNo = diag_frameNo;
    waitUntil {diag_frameNo > _frameNo};

    [_vehicle, _timeOld, _aeroConfigs] spawn orbis_aerodynamics_fnc_fixedWingLoop;
};

// get TAS and etc.
private _modelvelocity = velocityModelSpace _vehicle;
private _modelWind = _vehicle vectorWorldToModel wind;
private _trueAirVelocity = _modelvelocity vectorDiff _modelWind;

// get ground-speed based drag
private _dragGround = [_dragArray, _modelvelocity] call orbis_aerodynamics_fnc_getDrag;

// get TAS based drag
private _dragTAS = [_dragArray, _trueAirVelocity] call orbis_aerodynamics_fnc_getDrag;

// get and apply correction
private _forceCorrection = _dragTAS vectorDiff _dragGround;
private _worldDeltaV = _vehicle vectorModeltoWorld (_forceCorrection vectorMultiply (_timeStep / _mass));
_vehicle setVelocity (velocity _vehicle vectorAdd _worldDeltaV);

// wait a frame then spawn next loop
private _frameNo = diag_frameNo;
waitUntil {diag_frameNo > _frameNo};

[_vehicle, time, _aeroConfigs] spawn orbis_aerodynamics_fnc_fixedWingLoop;
