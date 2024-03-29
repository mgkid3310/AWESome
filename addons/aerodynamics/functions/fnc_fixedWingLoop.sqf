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

_aeroConfigs params ["_isAdvanced", "_aerodynamicsArray", "_speedPerformance", "_physicalProperty", "_configData"];
_aerodynamicsArray params ["_dragArray", "_liftArray", "_angleOfIncidence", "_flapsFCoef", "_gearsUpFCoef", "_airBrakeFCoef", "_torqueXCoef"];
_speedPerformance params ["_thrustCoef", "_vtolMode", "_altFullForce", "_altNoForce", "_speedStall", "_speedMax"];
_physicalProperty params ["_massError", "_massStandard", "_fuelCapacity"];

private _fWingData = _vehicle getVariable [QGVAR(fWingData), [airplaneThrottle _vehicle, velocityModelSpace _vehicle, _vehicle vectorWorldToModel wind/* , [] */]];
_fWingData params ["_throttleOld", "_modelVelocityOld", "_modelWindOld"/* , "_controlInputs" */];

// maintain input if dialog is open
/* if (dialog && !(_controlInputs isEqualTo [])) then {
	_controlInputs params ["_throttleInput", "_aileronPhase", "_aileronBPhase", "_aileronTPhase", "_elevatorPhase", "_rudderPhase", "_thrustVector", "_flapPhase", "_gearPhase", "_speedBrakePhase"];
	_vehicle setAirplaneThrottle _throttleInput;
	_vehicle animateSource ["aileron", _aileronPhase, true];
	_vehicle animateSource ["aileronB", _aileronBPhase, true];
	_vehicle animateSource ["aileronT", _aileronTPhase, true];
	_vehicle animateSource ["elevator", _elevatorPhase, true];
	_vehicle animateSource ["rudder", _rudderPhase, true];
	_vehicle animateSource ["thrustVector", _thrustVector, true];
	_vehicle animateSource ["flap", _flapPhase, true];
	_vehicle animateSource ["gear", _gearPhase, true];
	_vehicle animateSource ["speedBrake", _speedBrakePhase, true];
}; */

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
private _controlSensitivity = (_vehicle getVariable [QGVAR(controlSensitivity), 1]) * GVAR(controlSensitivityGlobal);
private _massStandardRatio = GVAR(massStandardRatio);
private _massFuelRatio = GVAR(massFuelRatio);

// read vehicle status
private _throttleInput = airplaneThrottle _vehicle;
private _throttleEffective = [_throttleOld, _throttleInput, _timeStep] call FUNC(getEffectiveThrottle);
private _throttleApply = _throttleEffective;
private _fuelCurrent = fuel _vehicle;
private _modelVelocityNew = velocityModelSpace _vehicle;
private _modelVelocity = (_modelVelocityNew vectorAdd _modelVelocityOld) vectorMultiply 0.5;
private _windSimulated = [_vehicle, GVAR(dynamicWindMode)] call FUNC(getWindVehicle);
private _modelWindNew = _vehicle vectorWorldToModel _windSimulated;
private _modelWind = (_modelWindNew vectorAdd _modelWindOld) vectorMultiply 0.5;
private _modelWindApply = _modelWind vectorMultiply GVAR(windMultiplier);
private _trueAirVelocity = _modelVelocity vectorDiff _modelWindApply;
private _altitudeAGLS = getPos _vehicle select 2;
private _engineDamage = _vehicle getHitPointDamage "hitEngine";
/* private _aileronPhase = _vehicle animationSourcePhase "aileron";
private _aileronBPhase = _vehicle animationSourcePhase "aileronB";
private _aileronTPhase = _vehicle animationSourcePhase "aileronT";
private _elevatorPhase = _vehicle animationSourcePhase "elevator";
private _rudderPhase = _vehicle animationSourcePhase "rudder"; */
private _thrustVector = 0 max (_vehicle animationSourcePhase "thrustVector");
private _flapPhase = _vehicle animationSourcePhase "flap";
private _gearPhase = _vehicle animationSourcePhase "gear";
private _speedBrakePhase = _vehicle animationSourcePhase "speedBrake";

// config data compatibility
private ["_abRatio"];
if (_configData param [0, 0] > 0) then {
	_configData params ["_configEnabled", "_engineData", "_weightData", "_miscData", "_codeIntercept"];
	_engineData params ["_abThrottle", "_refThrust", "_milThrust", "_abThrust", "_abFuelMultiplier"];
	_weightData params ["_gWeight", "_zfWeight", "_fWeight"];

	if (_abThrottle > 0) then {
		if (_throttleEffective > _abThrottle) then {
			_abRatio = linearConversion [_abThrottle, 1, _throttleEffective, GVAR(abMinRatio), 1, true];
			_fuelFlowMultiplier = _fuelFlowMultiplier * linearConversion [0, 1, _abRatio, 1, _abFuelMultiplier, true]; // includes thrust & TSFC increase
			_thrustMultiplier = _thrustMultiplier * linearConversion [0, 1, _abRatio, _milThrust, _abThrust, true] / _refThrust;
			_throttleApply = 1;
		} else {
			_thrustMultiplier = _thrustMultiplier * _milThrust / _refThrust;
			_throttleApply = linearConversion [0, _abThrottle, _throttleEffective, 0, 1, true];
		};
	};

	_massStandardRatio = _zfWeight / _gWeight;
	_massFuelRatio = _fWeight / _gWeight;

	{call compile _x} forEach _codeIntercept;
};
private _useExternalFuel = (_configData select 3) param [0, 0];
private _getExternalFuel = (_configData select 3) param [1, ""];
private _setExternalFuel = (_configData select 3) param [2, ""];

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
_massPylon = _massPylon * linearConversion [0.5, 1, _massStandard / GVAR(massStandardValue), 0.5, 1, true];

// get current vehicle mass
private ["_massCurrent", "_massFuel"];
if (_massError) then {
	_massCurrent = 10000;
} else {
	if !(_getExternalFuel isEqualTo "") then {
		_massFuel = linearConversion [0, 1, _fuelCurrent + ([_vehicle] call compile _getExternalFuel), 0, _massStandard * _massFuelRatio, false];
	} else {
		_massFuel = linearConversion [0, 1, _fuelCurrent, 0, _massStandard * _massFuelRatio, true];
	};

	if ((typeOf _vehicle) in ["JS_JC_FA18E", "JS_JC_FA18F"]) then {
		_massFuel = _massFuel + 1.1845 * linearConversion [0, 1, _vehicle animationPhase "auxtank_switch", 0, _massStandard * _massFuelRatio, true];
	};

	_massCurrent = _massStandard * _massStandardRatio + _massFuel * GVAR(fuelMassMultiplierGlobal) + _massPylon * _pylonMassMultiplier;
};

// apply effective mass
private _massEffective = (_massStandard ^ 2) * _controlSensitivity / _massCurrent;
_vehicle setVariable [QGVAR(massCurrent), _massCurrent];
_vehicle setMass _massEffective;

// F/A-18 canopy compatibility
if ((typeOf _vehicle) in ["JS_JC_FA18E", "JS_JC_FA18F"]) then {
	if ((_vehicle animationPhase "rcanopy_hide") > 0) then {
		_dragMultiplier = _dragMultiplier * 1.2;
	};
};

// build parameter array
private _paramDefault = [_modelVelocity, _massCurrent, _massError];
private _paramEnhanced = [_trueAirVelocity, _massStandard, _massError, _densityRatio, _altitudeAGLS];
private _paramPylon = [_trueAirVelocity, _massPylon, _massError, _densityRatio, _altitudeAGLS];
private _paramThrust = [_thrustCoef, _vtolMode, _thrustMultiplier, _engineDamage, _thrustVector];
private _paramLift = [_liftArray, _liftMultiplier, _flapsFCoef, _flapPhase];
private _paramDrag = [_dragArray, _dragMultiplier, _flapsFCoef, _flapPhase, _gearsUpFCoef, _gearPhase, _airBrakeFCoef, _speedBrakePhase];
private _paramPylonDrag = [_pylonDragArray, _dragMultiplier, 0, 0, 0, 1, 0, 0];
private _paramAltitude = [_altFullForce, _altNoForce, _altitudeASL];
private _paramAtmosphere = [_temperatureRatio, _pressureRatio];

// get correct fuel consumption
private _fuelFlowDefault = [0, 0.3 * _throttleEffective ^ 2 + 0.03] select isEngineOn _vehicle;
private _fuelFlowEnhanced = [_throttleApply, isEngineOn _vehicle, _fuelFlowMultiplier, _paramAtmosphere] call FUNC(getFuelFlowEnhanced);

// thrust correction
private _thrustDefault = [_throttleEffective, _paramDefault, _paramThrust, _speedMax, _paramAltitude] call FUNC(getThrustDefault);
private _thrustEnhanced = [_throttleApply, _paramEnhanced, _paramThrust, _speedMax, _paramAtmosphere] call FUNC(getThrustEnhanced);

// get lift force correction
private _liftDefault = [_paramDefault, _paramLift, _speedMax, _angleOfIncidence] call FUNC(getLiftDefault);
private _liftEnhanced = [_paramEnhanced, _paramLift, _speedMax, _angleOfIncidence] call FUNC(getLiftEnhanced);

// get drag force correction
private _dragDefault = [_paramDefault, _paramDrag, _paramAltitude, _isAdvanced] call FUNC(getDragDefault);
private _dragEnhanced = [_paramEnhanced, _paramDrag, _liftEnhanced, _speedStall] call FUNC(getDragEnhanced);
private _dragPylon = [_paramPylon, _paramPylonDrag] call FUNC(getDragEnhanced);

// get torque correction
// private _torqueDefault = [_paramDefault, _torqueXCoef, _massError] call FUNC(getTorque);
// private _torqueEnhanced = [_paramEnhanced, _torqueXCoef, _massError] call FUNC(getTorque);
// private _torqueCorrection = (_torqueEnhanced vectorMultiply (_massStandard / _massCurrent)) vectorDiff _torqueDefault;

// F/A-18 external fuel tank compatibility
private ["_auxtankSwitch", "_abSwitch"];
if ((typeOf _vehicle) in ["JS_JC_FA18E", "JS_JC_FA18F"]) then {
	_auxtankSwitch = _vehicle animationPhase "auxtank_switch";
	_abSwitch = [1, 2] select (_vehicle animationPhase "ab_switch" > 0.1);

	if (_auxtankSwitch > 0.05) then {
		_auxtankSwitch = _auxtankSwitch + ([0, 0.0005 * _abSwitch * _timeStep] select isEngineOn _vehicle);
		_auxtankSwitch = _auxtankSwitch - _fuelFlowEnhanced * _abSwitch * (_timeStep / _fuelCapacity) / 1.1845;
		_vehicle animate ["auxtank_switch", _auxtankSwitch max 0, true];
		_vehicle setFuel (_fuelCurrent + (_auxtankSwitch min 0));

		_fuelFlowEnhanced = 0;
	} else {
		_fuelFlowEnhanced = _fuelFlowEnhanced * _abSwitch;
	};
};

// apply fuel update
private _fuelCorrection = (_fuelFlowEnhanced - _fuelFlowDefault) * (_timeStep / _fuelCapacity);
_vehicle setFuel ((_fuelCurrent - _fuelCorrection) min 1);

private ["_fuelExternal", "_fuelDraw"];
if (_useExternalFuel > 0) then {
	_fuelExternal = [_vehicle] call compile _getExternalFuel;
	_fuelDraw = (1 - fuel _vehicle) min _fuelExternal;
	_vehicle setFuel (fuel _vehicle + _fuelDraw);
	[_vehicle, _fuelExternal - _fuelDraw] call compile _setExternalFuel;
};

// sum up forces and bring wheel friction into calculation if needed (todo)
private _defaultSum = _thrustDefault vectorAdd _liftDefault vectorAdd _dragDefault;
private _defaultApply = _defaultSum vectorMultiply (-1 * _massEffective / _massCurrent);
private _enhancedSum = _thrustEnhanced vectorAdd _liftEnhanced vectorAdd _dragEnhanced vectorAdd _dragPylon;
private _enhancedApply = _enhancedSum vectorMultiply (_massEffective / _massCurrent);
if ((isTouchingGround _vehicle) && GVAR(noForceOnGround)) then {
	_defaultApply set [0, 0];
	_defaultApply set [1, 0];
	_defaultApply set [2, 0];
	_enhancedApply set [0, 0];
	_enhancedApply set [1, 0];
	_enhancedApply set [2, 0];
};

// calculate and apply required impulse (force times timestep)
private ["_posCG", "_posCP", "_posTail"];
private ["_xTail", "_yTail", "_zTail"];
private ["_enhancedX", "_enhancedY", "_enhancedZ"];
if (GVAR(applyForce)) then {
	0 boundingBoxReal vehicle player params ["_posMin", "_posMax", "_bbRadius"];
	_posCG = getCenterOfMass vehicle player;
	_xTail = ((_posMin select 0) + (_posMax select 0)) / 2;
	_yTail = _posMin select 1;
	_zTail = ((_posMin select 2) + (_posMax select 2)) / 2;
	_posTail = [_xTail, _yTail, _zTail];
	_posCP = _posCG vectorAdd ((_posTail vectorDiff _posCG) vectorMultiply GVAR(cpPosRatio));

	_enhancedX = [_enhancedApply select 0, 0, 0];
	_enhancedY = [0, _enhancedApply select 1, 0];
	_enhancedZ = [0, 0, _enhancedApply select 2];

	_vehicle addForce [_vehicle vectorModelToWorld (_defaultApply vectorMultiply _timeStep), _posCG];
	_vehicle addForce [_vehicle vectorModelToWorld (_enhancedX vectorMultiply _timeStep), _posCP];
	_vehicle addForce [_vehicle vectorModelToWorld (_enhancedY vectorMultiply _timeStep), _posCG];
	_vehicle addForce [_vehicle vectorModelToWorld (_enhancedZ vectorMultiply _timeStep), _posCG];
};

// calculate and apply required angular impulse (torque times timestep)
// _vehicle addtorque [_vehicle vectorModelToWorld (_torqueCorrection vectorMultiply _timeStep)];

// save last manual control input
/* if (!dialog) then {
	_controlInputs = [_throttleInput, _aileronPhase, _aileronBPhase, _aileronTPhase, _elevatorPhase, _rudderPhase, _thrustVector, _flapPhase, _gearPhase, _speedBrakePhase];
}; */

// report if needed (dev script)
// diag_log format ["orbis_aerodynamics _thrustDefault: %1, _thrustEnhanced: %2, _liftDefault: %3, _liftEnhanced: %4", _thrustDefault, _thrustEnhanced, _liftDefault, _liftEnhanced];
// diag_log format ["orbis_aerodynamics _massCurrent: %1, _dragDefault: %2, _dragEnhanced: %3, _dragPylon: %4", _massCurrent, _dragDefault, _dragEnhanced, _dragPylon];

// 3rd party support
_vehicle setVariable [QGVAR(effectiveThrottle), _throttleEffective];
_vehicle setVariable [QGVAR(fuelFlowEnhanced), _fuelFlowEnhanced];

// save data for next frame
_vehicle setVariable [QGVAR(fWingData), [_throttleEffective, _modelVelocityNew, _modelWindNew/* , _controlInputs */]];
