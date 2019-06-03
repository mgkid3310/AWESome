private _vehicle = _this select 0;

private ["_isAdvanced", "_dragArray", "_liftArray", "_angleOfIndicence", "_torqueXCoef", "_speedStall", "_speedMax", "_massError", "_massStandard", "_fuelCapacity"];
private _className = typeOf _vehicle;
private _class = (configFile >> "CfgVehicles" >> _className);

// _aerodynamicsArray
// need to find out more
_isAdvanced = toLower getText (_class >> "simulation") isEqualTo "planex";
if (_isAdvanced) then {
	_dragArray = [getArray (_class >> "airFrictionCoefs2"), getArray (_class >> "airFrictionCoefs1"), getArray (_class >> "airFrictionCoefs0")];
} else {
	_dragArray = [getArray (_class >> "airFrictionCoefs2"), getArray (_class >> "airFrictionCoefs1"), getArray (_class >> "airFrictionCoefs0")];
};

_liftArray = getArray (_class >> "envelope");
_angleOfIndicence = getNumber (_class >> "angleOfIndicence");
if (isNumber (_class >> "draconicTorqueXCoef")) then {
	_torqueXCoef = getNumber (_class >> "draconicTorqueXCoef");
} else {
	_torqueXCoef = getArray (_class >> "draconicTorqueXCoef");
};

// _speedPerformance
_thrustCoef = getArray (_class >> "thrustCoef");
if !(count _thrustCoef > 0) then {
	_thrustCoef = [1, 1];
};
_altFullForce = getNumber (_class >> "altFullForce");
_altNoForce = getNumber (_class >> "altNoForce");
_speedStall = getNumber (_class >> "stallSpeed");
_speedMax = getNumber (_class >> "maxSpeed");

// _physicalProperty
_massError = false;
_massStandard = getMass _vehicle;
if !(_massStandard > 0) then {
	_massStandard = 10000;
	_massError = true;
};
_fuelCapacity = getNumber (_class >> "fuelCapacity");

private _aerodynamicsArray = [_dragArray, _liftArray, _angleOfIndicence, _torqueXCoef];
private _speedPerformance = [_thrustCoef, _altFullForce, _altNoForce, _speedStall, _speedMax];
private _physicalProperty = [_massError, _massStandard, _fuelCapacity];
private _return = [_isAdvanced, _aerodynamicsArray, _speedPerformance, _physicalProperty];

// report if needed (dev script)
// diag_log format ["orbis_aerodynamics aeroConfig: %1", _return];

_return
