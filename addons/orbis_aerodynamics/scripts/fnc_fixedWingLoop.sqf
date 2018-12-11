params ["_vehicle", "_player", "_timeOld"];

private _timeStep = time - _timeOld;
if !(_timeStep > 0) exitWith {};

// load aerodynamic & etc. data
private _aeroConfigs = _vehicle getVariable ["orbis_aerodynamics_aeroConfig", false];
if !(_aeroConfigs isEqualType []) then {
    _aeroConfigs = [_vehicle] call orbis_aerodynamics_fnc_getAeroConfig;
    _vehicle setVariable ["orbis_aerodynamics_aeroConfig", _aeroConfigs];
};

_aeroConfigs params ["_isAdvanced", "_aerodynamicsArray", "_speedPerformance", "_physicalProperty"];
_aerodynamicsArray params ["_dragArray", "_liftArray", "_angleOfIndicence", "_torqueXCoef"];
_speedPerformance params ["_speedStall", "_speedMax"];
_physicalProperty params ["_massStandard", "_massError"];

private _massCurrent = getMass _vehicle;
if !(_massCurrent > 0) then {
    _massCurrent = _massStandard;
};

// atmosphere data setup
private _altitude = ((getPosASL _vehicle) select 2) * orbis_aerodynamics_altitudeMultiplier;
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

// build parameter array
private _paramDefault = [_modelvelocity, _massStandard];
private _paramEnhanced = [_trueAirVelocity, _massStandard, _densityRatio];

// get lift force correction
private _liftDefault = [_paramDefault, _liftArray, _speedMax, _angleOfIndicence] call orbis_aerodynamics_fnc_getLiftDefault;
private _liftEnhanced = [_paramEnhanced, _liftArray, _speedMax, _angleOfIndicence] call orbis_aerodynamics_fnc_getLiftEnhanced;
private _liftCorrection = _liftEnhanced vectorDiff _liftDefault;

// get drag force correction
private _dragDefault = [_paramDefault, _dragArray, _isAdvanced] call orbis_aerodynamics_fnc_getDragDefault;
private _dragEnhanced = [_paramEnhanced, _dragArray, _liftEnhanced, _speedStall] call orbis_aerodynamics_fnc_getDragEnhanced;
private _dragCorrection = _dragEnhanced vectorDiff _dragDefault;

// get torque correction
// private _torqueDefault = [_paramDefault, _torqueXCoef, _massError] call orbis_aerodynamics_fnc_getTorque;
// private _torqueEnhanced = [_paramEnhanced, _torqueXCoef, _massError] call orbis_aerodynamics_fnc_getTorque;
// private _torqueCorrection = (_torqueEnhanced vectorMultiply (_massStandard / _massCurrent)) vectorDiff _torqueDefault;

// sum up corrections and bring wheel friction into calculation if needed (todo)
private _forceApply = _liftCorrection vectorAdd _dragCorrection;
if (isTouchingGround _vehicle) then {
    _forceApply set [0, 0];
    _forceApply set [1, 0];
    _forceApply set [2, 0];
    _torqueCorrection set [0, 0];
    _torqueCorrection set [1, 0];
    _torqueCorrection set [2, 0];
};

// calculate and apply required impulse (force times timestep)
_vehicle addForce [_vehicle vectorModelToWorld (_forceApply vectorMultiply _timeStep), getCenterOfMass _vehicle];

// calculate and apply required angular impulse (torque times timestep)
// _vehicle addtorque [_vehicle vectorModelToWorld (_torqueCorrection vectorMultiply _timeStep)];

// report if needed (dev script)
// diag_log format ["orbis_aerodynamics _density: %1, _modelvelocity: %2, _trueAirVelocity: %3, _dragDefault: %4, _dragEnhanced: %5, _forceApply: %6", _density, _modelvelocity, _trueAirVelocity, _dragDefault, _dragEnhanced, _forceApply];
