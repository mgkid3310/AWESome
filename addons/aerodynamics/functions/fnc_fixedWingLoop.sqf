#include "script_component.hpp"

params ["_vehicle", "_timeOld"];

private _timeStep = time - _timeOld;
if !(_timeStep > 0) exitWith {};

// load aerodynamic & etc. data
private _aeroConfigs = _vehicle getVariable [QGVAR(aeroConfig), false];
if !(_aeroConfigs isEqualType []) then {
	_aeroConfigs = [_vehicle] call FUNC(getAeroConfig);
	_vehicle setVariable [QGVAR(aeroConfig), _aeroConfigs];
};

_aeroConfigs params ["_isAdvanced", "_aerodynamicsArray", "_speedPerformance", "_physicalProperty"];
_aerodynamicsArray params ["_dragArray", "_liftArray", "_angleOfIndicence", "_flapsFCoef", "_gearsUpFCoef", "_airBrakeFCoef", "_torqueXCoef"];
_speedPerformance params ["_thrustCoef", "_vtolMode", "_altFullForce", "_altNoForce", "_speedStall", "_speedMax"];
_physicalProperty params ["_massError", "_massStandard", "_fuelCapacity"];

private _fWingData = _vehicle getVariable [QGVAR(fWingData), [airplaneThrottle _vehicle, velocityModelSpace _vehicle, _vehicle vectorWorldToModel wind]];
_fWingData params ["_throttleOld", "_modelVelocityOld", "_modelWindOld"];

// atmosphere data setup
private _altitudeASL = getPosASL _vehicle select 2;
private ["_temperatureSL", "_pressureSL", "_humidity"];
if (EGVAR(main,hasACEWeather)) then {
	_temperatureSL = ace_weather_currentTemperature; // Celsius
	_pressureSL = 0 call ace_weather_fnc_calculateBarometricPressure; // hPa
	_humidity = ace_weather_currentHumidity; // relative
} else {
	_temperatureSL = 15; // Celsius
	_pressureSL = 1013.25; // hPa
	_humidity = linearConversion [0, 0.5, overcast, 0, 1, true]; // relative
};

private _temperatureArray = [_altitudeASL, _temperatureSL] call FUNC(getAirTemperature);
private _temperature = _temperatureArray select 4; // Celsius
private _pressure = [_altitudeASL, _temperatureArray, _pressureSL] call FUNC(getAirPressure); // hPa
private _density = [_altitudeASL, _temperature, _pressure, _humidity] call FUNC(getAirDensity); // kg/m^3

private _temperatureRatio = (_temperature + 273.15) / 288.15;
private _pressureRatio = _pressure / 1013.25;
private _densityRatio = _density / 1.225;

// calculate multipliers
private _fuelFlowMultiplier = (_vehicle getVariable [QGVAR(fuelFlowMultiplier), 1]) * GVAR(fuelFlowMultiplierGlobal);
private _thrustMultiplier = (_vehicle getVariable [QGVAR(thrustMultiplier), 1]) * GVAR(thrustMultiplierGlobal);
private _liftMultiplier = (_vehicle getVariable [QGVAR(liftMultiplier), 1]) * GVAR(liftMultiplierGlobal);
private _dragMultiplier = (_vehicle getVariable [QGVAR(dragMultiplier), 1]) * GVAR(dragMultiplierGlobal);
private _pylonMassMultiplier = (_vehicle getVariable [QGVAR(pylonMassMultiplier), 1]) * GVAR(pylonMassMultiplierGlobal);
private _pylonDragMultiplier = (_vehicle getVariable [QGVAR(pylonDragMultiplier), 1]) * GVAR(pylonDragMultiplierGlobal);

// get TAS and etc.
private _modelVelocityNew = velocityModelSpace _vehicle;
private _modelVelocity = (_modelVelocityNew vectorAdd _modelVelocityOld) vectorMultiply 0.5;
private _windSimulated = [_vehicle, GVAR(dynamicWindMode)] call FUNC(getWindVehicle);
private _modelWindNew = _vehicle vectorWorldToModel _windSimulated;
private _modelWind = (_modelWindNew vectorAdd _modelWindOld) vectorMultiply 0.5;
private _modelWindApply = _modelWind vectorMultiply GVAR(windMultiplier);
private _trueAirVelocity = _modelVelocity vectorDiff _modelWindApply;
private _altitudeAGLS = getPos _vehicle select 2;
private _engineDamage = _vehicle getHitPointDamage "hitEngine";
private _thrustVector = 0 max (_vehicle animationSourcePhase "thrustVector");
private _flapStatus = _vehicle animationSourcePhase "flap";
private _gearStatus = _vehicle animationSourcePhase "gear";
private _airBrakeStatus = _vehicle animationSourcePhase "speedBrake";

// correct fuel consumption
private _throttleInput = airplaneThrottle _vehicle;
private _throttle = [_throttleOld, _throttleInput, _timeStep] call FUNC(getEffectiveThrottle);
private _fuelCurrent = fuel _vehicle;
private _fuelFlowDefault = 0.3 * _throttle ^ 2 + 0.03;
private _fuelFlowEnhanced = [_throttle, _fuelFlowMultiplier] call FUNC(getFuelFlowEnhanced);
_vehicle setFuel (_fuelCurrent - (_fuelFlowEnhanced - _fuelFlowDefault) * (_timeStep / _fuelCapacity));

// 3rd party support
_vehicle setVariable [QGVAR(effectiveThrottle), _throttle];
_vehicle setVariable [QGVAR(fuelFlowEnhanced), _fuelFlowEnhanced];

// check for ammo on pylons
private ["_magazineClass", "_ammoClass", "_massFull", "_countFull", "_massMagazine", "_airFriction", "_sideAirFriction"];
private _massPylon = 0;
private _pylonDragCoef2 = [0, 0, 0];
{
	_magazineClass = (configFile >> "CfgMagazines" >> _x);
	_ammoClass = (configFile >> "CfgAmmo" >> getText (_magazineClass >> "ammo"));

	_massFull = getNumber (_magazineClass >> "mass");
	_countNow = _vehicle ammoOnPylon (_forEachIndex + 1);
	_countFull = 1 max getNumber (_magazineClass >> "count");
	_massMagazine = _massFull * _countNow / _countFull;;
	_massPylon = _massPylon + _massMagazine;

	_airFriction = 0 max getNumber (_ammoClass >> "airFriction");
	_sideAirFriction = 0 max getNumber (_ammoClass >> "sideAirFriction");
	_coefMagazine = [_sideAirFriction, _sideAirFriction, _airFriction] vectorMultiply (_massMagazine * GVAR(pylonDragRatio));
	_pylonDragCoef2 = _pylonDragCoef2 vectorAdd _coefMagazine;

	// report if needed (dev script)
	// diag_log format ["orbis_aerodynamics pylonNum: %1, magazine: %2, _massMagazine: %3, _coefMagazine: %4", _forEachIndex + 1, _x, _massMagazine, _coefMagazine];
} forEach (getPylonMagazines _vehicle);
private _pylonDragArray = [_pylonDragCoef2 vectorMultiply (_pylonDragMultiplier / (1 max _massPylon)), [0, 0, 0], [0, 0, 0]];
_massPylon = _massPylon * _pylonMassMultiplier;

// get current vehicle mass and apply
private ["_massCurrent", "_massFuel"];
if (_massError) then {
	_massCurrent = 10000;
} else {
	_massFuel = 0.8 * _fuelCurrent * _fuelCapacity;
	if ((typeOf _vehicle) in ["JS_JC_FA18E", "JS_JC_FA18F"]) then {
		_massFuel = _massFuel + 0.8 * (_vehicle animationPhase "auxtank_switch") * _fuelCapacity;
	};
	_massCurrent = (_massStandard * GVAR(massStandardRatio)) + _massFuel + _massPylon;
};
_vehicle setMass _massCurrent;

// F/A-18 canopy compatibility
if ((typeOf _vehicle) in ["JS_JC_FA18E", "JS_JC_FA18F"]) then {
	if ((_vehicle animationPhase "rcanopy_hide") > 0) then {
		_dragMultiplier = _dragMultiplier * 1.2;
	};
};

// build parameter array
private _paramDefault = [_modelVelocity, _massCurrent, _massError];
private _paramEnhanced = [_trueAirVelocity, _massStandard, _massError, _densityRatio, _altitudeAGLS];
private _paramPylon = [_trueAirVelocity, _massPylon, _massError, _densityRatio];
private _paramThrust = [_thrustCoef, _vtolMode, _thrustMultiplier, _throttle, _engineDamage, _thrustVector];
private _paramLift = [_liftArray, _liftMultiplier, _flapsFCoef, _flapStatus];
private _paramDrag = [_dragArray, _dragMultiplier, _flapsFCoef, _flapStatus, _gearsUpFCoef, _gearStatus, _airBrakeFCoef, _airBrakeStatus];
private _paramPylonDrag = [_pylonDragArray, _dragMultiplier, 0, 0, 0, 1, 0, 0];
private _paramAltitude = [_altFullForce, _altNoForce, _altitudeASL];
private _paramAtmosphere = [_temperatureRatio, _pressureRatio];

// thrust correction
private _thrustDefault = [_paramDefault, _paramThrust, _speedMax, _paramAltitude] call FUNC(getThrustDefault);
private _thrustEnhanced = [_paramEnhanced, _paramThrust, _speedMax, _paramAtmosphere] call FUNC(getThrustEnhanced);
private _thrustCorrection = _thrustEnhanced vectorDiff _thrustDefault;

// get lift force correction
private _liftDefault = [_paramDefault, _paramLift, _speedMax, _angleOfIndicence] call FUNC(getLiftDefault);
private _liftEnhanced = [_paramEnhanced, _paramLift, _speedMax, _angleOfIndicence] call FUNC(getLiftEnhanced);
private _liftCorrection = _liftEnhanced vectorDiff _liftDefault;

// get drag force correction
private _dragDefault = [_paramDefault, _paramDrag, _paramAltitude, _isAdvanced] call FUNC(getDragDefault);
private _dragEnhanced = [_paramEnhanced, _paramDrag, _liftEnhanced, _speedStall] call FUNC(getDragEnhanced);
private _dragPylon = [_paramPylon, _paramPylonDrag] call FUNC(getDragEnhanced);
private _dragCorrection = (_dragEnhanced vectorAdd _dragPylon) vectorDiff _dragDefault;

// get torque correction
// private _torqueDefault = [_paramDefault, _torqueXCoef, _massError] call FUNC(getTorque);
// private _torqueEnhanced = [_paramEnhanced, _torqueXCoef, _massError] call FUNC(getTorque);
// private _torqueCorrection = (_torqueEnhanced vectorMultiply (_massStandard / _massCurrent)) vectorDiff _torqueDefault;

// sum up corrections and bring wheel friction into calculation if needed (todo)
private _forceApply = _thrustCorrection vectorAdd _liftCorrection vectorAdd _dragCorrection;
if ((isTouchingGround _vehicle) && GVAR(noForceOnGround)) then {
	_forceApply set [0, 0];
	_forceApply set [1, 0];
	_forceApply set [2, 0];
	// _torqueCorrection set [0, 0];
	// _torqueCorrection set [1, 0];
	// _torqueCorrection set [2, 0];
};

// calculate and apply required impulse (force times timestep)
if (GVAR(applyForce)) then {
	_vehicle addForce [_vehicle vectorModelToWorld (_forceApply vectorMultiply _timeStep), getCenterOfMass _vehicle];
};

// calculate and apply required angular impulse (torque times timestep)
// _vehicle addtorque [_vehicle vectorModelToWorld (_torqueCorrection vectorMultiply _timeStep)];

// report if needed (dev script)
// diag_log format ["orbis_aerodynamics _thrustDefault: %1, _thrustEnhanced: %2, _liftDefault: %3, _liftEnhanced: %4", _thrustDefault, _thrustEnhanced, _liftDefault, _liftEnhanced];
// diag_log format ["orbis_aerodynamics _massCurrent: %1, _dragDefault: %2, _dragEnhanced: %3, _dragPylon: %4", _massCurrent, _dragDefault, _dragEnhanced, _dragPylon];

_vehicle setVariable [QGVAR(fWingData), [_throttle, _modelVelocityNew, _modelWindNew]];
