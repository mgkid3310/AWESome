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
_aerodynamicsArray params ["_dragArray", "_liftArray", "_angleOfIndicence", "_torqueXCoef"];
_speedPerformance params ["_thrustCoef", "_altFullForce", "_altNoForce", "_speedStall", "_speedMax"];
_physicalProperty params ["_massError", "_massStandard", "_fuelCapacity"];

private _aeroData = _vehicle getVariable [QGVAR(aeroData), [airplaneThrottle _vehicle, velocityModelSpace _vehicle, _vehicle vectorWorldToModel wind]];
_aeroData params ["_throttleOld", "_modelVelocityOld", "_modelWindOld"];

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

private _temperatureRatio = (_temperature + 273.15) / (_temperatureSL + 273.15);
private _pressureRatio = _pressure / _pressureSL;
private _densityRatio = _density / 1.2754;

// get TAS and etc.
private _modelVelocityNew = velocityModelSpace _vehicle;
private _modelVelocity = (_modelVelocityNew vectorAdd _modelVelocityOld) vectorMultiply 0.5;
private _modelWindNew = _vehicle vectorWorldToModel wind;
private _modelWind = (_modelWindNew vectorAdd _modelWindOld) vectorMultiply 0.5;
private _modelWindApply = _modelWind vectorMultiply GVAR(windMultiplier);
private _trueAirVelocity = _modelVelocity vectorDiff _modelWindApply;
private _altitudeAGLS = getPos _vehicle select 2;
private _engineDamage = _vehicle getHitPointDamage "hitEngine";
private _thrustVector = _vehicle animationSourcePhase "thrustVector";

// correct fuel consumption
private _throttleInput = airplaneThrottle _vehicle;
private _throttle = [_throttleOld, _throttleInput, _timeStep] call FUNC(getEffectiveThrottle);
private _fuelCurrent = fuel _vehicle;
private _fuelFlowDefault = 0.3 * _throttle ^ 2 + 0.03;
private _fuelFlowEnhanced = [_throttle] call FUNC(getFuelFlowEnhanced);
_vehicle setFuel (_fuelCurrent - (_fuelFlowEnhanced - _fuelFlowDefault) * (_timeStep / _fuelCapacity));

// 3rd party support
GVAR(effectiveThrottle) = _throttle;
GVAR(fuelFlowEnhanced) = _fuelFlowEnhanced;

// check for ammo on pylons
private ["_magazineClass", "_ammoClass", "_massFull", "_countFull", "_massMagazine", "_airFriction", "_sideAirFriction", "_pylonDragCoef2"];
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
private _pylonDragArray = [_pylonDragCoef2 vectorMultiply (1 / (1 max _massPylon)), [0, 0, 0], [0, 0, 0]];

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

// get effective drag config
private _dragArrayEff = _dragArray;
private _dragMultiplier = 1;

// F/A-18 canopy compatibility
if ((typeOf _vehicle) in ["JS_JC_FA18E", "JS_JC_FA18F"]) then {
	if ((_vehicle animationPhase "rcanopy_hide") > 0) then {
		_dragMultiplier = _dragMultiplier * 1.2;
	};
};

// devmode
_dragMultiplier = _dragMultiplier * GVAR(dragMultiplier);

// build parameter array
private _paramDefault = [_modelVelocity, _massCurrent, _massError];
private _paramEnhanced = [_trueAirVelocity, _massStandard, _massError, _densityRatio, _altitudeAGLS];
private _paramPylon = [_trueAirVelocity, _massPylon, _massError, _densityRatio];
private _paramThrust = [_thrustCoef, _throttle, _engineDamage, _thrustVector];
private _paramAltitude = [_altFullForce, _altNoForce, _altitudeASL];
private _paramAtmosphere = [_temperatureRatio, _pressureRatio];

// thrust correction
private _thrustDefault = [_paramDefault, _paramThrust, _speedMax, _paramAltitude] call FUNC(getThrustDefault);
private _thrustEnhanced = [_paramEnhanced, _paramThrust, _speedMax, _paramAtmosphere] call FUNC(getThrustEnhanced);
private _thrustCorrection = _thrustEnhanced vectorDiff _thrustDefault;

// get lift force correction
private _liftDefault = [_paramDefault, _liftArray, _speedMax, _angleOfIndicence] call FUNC(getLiftDefault);
private _liftEnhanced = [_paramEnhanced, _liftArray, _speedMax, _angleOfIndicence] call FUNC(getLiftEnhanced);
private _liftCorrection = _liftEnhanced vectorDiff _liftDefault;

// get drag force correction
private _dragDefault = [_paramDefault, _dragArrayEff, _paramAltitude, _isAdvanced] call FUNC(getDragDefault);
private _dragEnhanced = [_paramEnhanced, _dragArrayEff, _dragMultiplier, _liftEnhanced, _speedStall] call FUNC(getDragEnhanced);
private _dragPylon = [_paramPylon, _pylonDragArray, _dragMultiplier] call FUNC(getDragEnhanced);
private _dragCorrection = (_dragEnhanced vectorAdd _dragPylon) vectorDiff _dragDefault;

// get torque correction
// private _torqueDefault = [_paramDefault, _torqueXCoef, _massError] call FUNC(getTorque);
// private _torqueEnhanced = [_paramEnhanced, _torqueXCoef, _massError] call FUNC(getTorque);
// private _torqueCorrection = (_torqueEnhanced vectorMultiply (_massStandard / _massCurrent)) vectorDiff _torqueDefault;

// sum up corrections and bring wheel friction into calculation if needed (todo)
private _forceApply = _thrustCorrection vectorAdd _liftCorrection vectorAdd _dragCorrection;
if ((isTouchingGround _vehicle) && GVAR(noForceoOnGround)) then {
	_forceApply set [0, 0];
	_forceApply set [1, 0];
	_forceApply set [2, 0];
	// _torqueCorrection set [0, 0];
	// _torqueCorrection set [1, 0];
	// _torqueCorrection set [2, 0];
};

// calculate and apply required impulse (force times timestep)
_vehicle addForce [_vehicle vectorModelToWorld (_forceApply vectorMultiply _timeStep), getCenterOfMass _vehicle];

// calculate and apply required angular impulse (torque times timestep)
// _vehicle addtorque [_vehicle vectorModelToWorld (_torqueCorrection vectorMultiply _timeStep)];

// report if needed (dev script)
// diag_log format ["orbis_aerodynamics _massCurrent: %1, _dragArrayEff: %2, _pylonDragArray: %3, _dragDefault: %4, _dragEnhanced: %5, _dragPylon: %6", _massCurrent, _dragArrayEff, _pylonDragArray, _dragDefault, _dragEnhanced, _dragPylon];
// diag_log format ["orbis_aerodynamics _massCurrent: %1, _forceApply: %2, _timeStep: %3", _massCurrent, _forceApply, _timeStep];

_vehicle setVariable [QGVAR(aeroData), [_throttle, _modelVelocityNew, _modelWindNew]];
