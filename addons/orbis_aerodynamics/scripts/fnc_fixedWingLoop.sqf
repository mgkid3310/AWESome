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

private _dragArray = _aeroConfigs select 0;
private _liftArray = _aeroConfigs select 1;
private _performanceArray = _aeroConfigs select 2;

private _speedMax = _performanceArray select 0;
private _speedStall = _performanceArray select 1;
private _angleOfIndicence = _performanceArray select 2;
private _massStandard = _performanceArray select 3;

private _massCurrent = getMass _vehicle;
if !(_massCurrent > 0) then {
    _massCurrent = _massStandard;
};

// atmosphere data setup
private _altitude = (getPosASL _vehicle) select 2;
private ["_temperature", "_pressure", "_humidity"];
if (orbis_awesome_hasACEWeather) then {
    _temperature = _altitude call ace_weather_fnc_calculateTemperatureAtHeight; // Celsius
    _pressure = _altitude call ace_weather_fnc_calculateBarometricPressure; // hPa
    _humidity = ace_weather_currentHumidity; // relative
} else {
    _temperature = 25 - (0.0065 * _altitude); // Celsius
    _pressure = 1013.25 * ((298.15 / (273.15 + _temperature)) ^ -5.2557812); // hPa
    _humidity = linearConversion [0, 0.5, overcast, 0, 1, true]; // relative
};
private _density = [_temperature, _pressure, _humidity] call orbis_aerodynamics_fnc_getAirDensity; // kg/m^3
private _densityRatio = _density / 1.2754;

// get TAS and etc.
private _modelvelocity = velocityModelSpace _vehicle;
private _modelWind = _vehicle vectorWorldToModel wind;
private _windMultiplier = missionNamespace getVariable ["orbis_aerodynamics_windMultiplier", 1];
private _windApply = _modelWind vectorMultiply _windMultiplier;
private _trueAirVelocity = _modelvelocity vectorDiff _windApply;

// get drag correction
private _dragGround = [_modelvelocity, _dragArray, _densityRatio, _massStandard] call orbis_aerodynamics_fnc_getDrag;
private _dragTAS = [_trueAirVelocity, _dragArray, _densityRatio, _massStandard] call orbis_aerodynamics_fnc_getDrag;
private _forceDragCorrection = _dragTAS vectorDiff _dragGround;

// get lift correction
private _liftGround = [_modelvelocity, _liftArray, _speedMax, _angleOfIndicence, _densityRatio, _massStandard] call orbis_aerodynamics_fnc_getlift;
private _liftTAS = [_trueAirVelocity, _liftArray, _speedMax, _angleOfIndicence, _densityRatio, _massStandard] call orbis_aerodynamics_fnc_getlift;
private _forceLiftCorrection = _liftTAS vectorDiff _liftGround;

// sum up corrections and bring wheel friction into calculation if needed (todo)
private _forceApply = _forceDragCorrection vectorAdd _forceLiftCorrection;
if (isTouchingGround _vehicle) then {
    _forceApply set [0, 0];
    _forceApply set [1, 0];
    _forceApply set [2, 0];
};

// get DeltaV needed and apply it
private _modelDeltaV = _forceApply vectorMultiply (_timeStep / _massCurrent);
_vehicle setVelocityModelSpace (_modelvelocity vectorAdd _modelDeltaV);

// report if needed (dev script)
// diag_log format ["orbis_aerodynamics _forceApply: %1, _dragGround: %2, _dragTAS: %3, _liftGround: %4, _liftTAS: %5", _forceApply, _dragGround, _dragTAS, _liftGround, _liftTAS];
