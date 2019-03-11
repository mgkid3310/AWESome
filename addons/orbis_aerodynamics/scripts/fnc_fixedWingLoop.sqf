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
_speedPerformance params ["_thrustCoef", "_altFullForce", "_altNoForce", "_speedStall", "_speedMax"];
_physicalProperty params ["_massError", "_massStandard", "_fuelCapacity"];

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
    _coefMagazine = [_sideAirFriction, _sideAirFriction, _airFriction] vectorMultiply (_massMagazine * orbis_aerodynamics_pylonDragRatio);
    _pylonDragCoef2 = _pylonDragCoef2 vectorAdd _coefMagazine;

    // report if needed (dev script)
    // diag_log format ["orbis_aerodynamics pylonNum: %1, magazine: %2, _massMagazine: %3, _coefMagazine: %4", _forEachIndex + 1, _x, _massMagazine, _coefMagazine];
} forEach (getPylonMagazines _vehicle);
private _pylonDragArray = [_pylonDragCoef2 vectorMultiply (1 / (1 max _massPylon)), [0, 0, 0], [0, 0, 0]];

// get current vehicle mass and apply
private ["_massCurrent", "_fuelMass"];
if (_massError) then {
    _massCurrent = 10000;
} else {
    _fuelMass = 0.8 * (fuel _vehicle) * _fuelCapacity;
    if ((typeOf _vehicle) in ["JS_JC_FA18E", "JS_JC_FA18F"]) then {
        _fuelMass = _fuelMass + 0.8 * (_vehicle animationPhase "auxtank_switch") * _fuelCapacity;
    };
    _massCurrent = (_massStandard * orbis_aerodynamics_massStandardRatio) + _fuelMass + _massPylon;
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
_dragMultiplier = _dragMultiplier * orbis_aerodynamics_dragMultiplier;

// atmosphere data setup
private _altitude = ((getPosASL _vehicle) select 2) * orbis_aerodynamics_altitudeMultiplier;
private ["_temperatureSL", "_pressureSL", "_humidity"];
if (orbis_awesome_hasACEWeather) then {
	_temperatureSL = ace_weather_currentTemperature; // Celsius
	_pressureSL = 0 call ace_weather_fnc_calculateBarometricPressure; // hPa
    _humidity = ace_weather_currentHumidity; // relative
} else {
	_temperatureSL = 15; // Celsius
	_pressureSL = 1013.25; // hPa
    _humidity = linearConversion [0, 0.5, overcast, 0, 1, true]; // relative
};

private _temperatureArray = [_altitude, _temperatureSL] call orbis_aerodynamics_fnc_getAirTemperature;
private _temperature = _temperatureArray select 4; // Celsius
private _pressure = [_altitude, _temperatureArray, _pressureSL] call orbis_aerodynamics_fnc_getAirPressure; // hPa
private _density = [_altitude, _temperature, _pressure, _humidity] call orbis_aerodynamics_fnc_getAirDensity; // kg/m^3

private _temperatureRatio = (_temperature + 273.15) / (_temperatureSL + 273.15);
private _pressureRatio = _pressure / _pressureSL;
private _densityRatio = _density / 1.2754;

// get TAS and etc.
private _modelvelocity = velocityModelSpace _vehicle;
private _modelWind = _vehicle vectorWorldToModel wind;
private _windApply = _modelWind vectorMultiply orbis_aerodynamics_windMultiplier;
private _trueAirVelocity = _modelvelocity vectorDiff _windApply;

// build parameter array
private _paramDefault = [_modelvelocity, _massCurrent, _massError];
private _paramEnhanced = [_trueAirVelocity, _massStandard, _massError, _densityRatio];
private _paramThrust = [_thrustCoef, airplaneThrottle _vehicle];
private _paramAltitude = [_altFullForce, _altNoForce, _altitude];
private _paramAtmosphere = [_temperatureRatio, _pressureRatio];
private _paramPylon = [_trueAirVelocity, _massPylon, _massError, _densityRatio];

// thrust correction
private _thrustDefault = [_paramDefault, _paramThrust, _speedMax, _paramAltitude] call orbis_aerodynamics_fnc_getThrustDefault;
private _thrustEnhanced = [_paramEnhanced, _paramThrust, _speedMax, _paramAtmosphere] call orbis_aerodynamics_fnc_getThrustEnhanced;
private _thrustCorrection = _thrustEnhanced vectorDiff _thrustDefault;

// get lift force correction
private _liftDefault = [_paramDefault, _liftArray, _speedMax, _angleOfIndicence] call orbis_aerodynamics_fnc_getLiftDefault;
private _liftEnhanced = [_paramEnhanced, _liftArray, _speedMax, _angleOfIndicence] call orbis_aerodynamics_fnc_getLiftEnhanced;
private _liftCorrection = _liftEnhanced vectorDiff _liftDefault;

// get drag force correction
private _dragDefault = [_paramDefault, _dragArrayEff, _paramAltitude, _isAdvanced] call orbis_aerodynamics_fnc_getDragDefault;
private _dragEnhanced = [_paramEnhanced, _dragArrayEff, _dragMultiplier, _liftEnhanced, _speedStall] call orbis_aerodynamics_fnc_getDragEnhanced;
private _dragPylon = [_paramPylon, _pylonDragArray, _dragMultiplier] call orbis_aerodynamics_fnc_getDragEnhanced;
private _dragCorrection = (_dragEnhanced vectorAdd _dragPylon) vectorDiff _dragDefault;

// get torque correction
// private _torqueDefault = [_paramDefault, _torqueXCoef, _massError] call orbis_aerodynamics_fnc_getTorque;
// private _torqueEnhanced = [_paramEnhanced, _torqueXCoef, _massError] call orbis_aerodynamics_fnc_getTorque;
// private _torqueCorrection = (_torqueEnhanced vectorMultiply (_massStandard / _massCurrent)) vectorDiff _torqueDefault;

// sum up corrections and bring wheel friction into calculation if needed (todo)
private _forceApply = _thrustCorrection vectorAdd _liftCorrection vectorAdd _dragCorrection;
if (isTouchingGround _vehicle) then {
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
