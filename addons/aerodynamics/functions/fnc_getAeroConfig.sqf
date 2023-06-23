#include "script_component.hpp"

params ["_vehicle"];

private ["_isAdvanced",
	"_dragArray", "_liftArray", "_angleOfIncidence", "_flapsFCoef", "_gearsUpFCoef", "_airBrakeFCoef", "_torqueXCoef",
	"_thrustCoef", "_vtolMode", "_altFullForce", "_altNoForce", "_speedStall", "_speedMax",
	"_massError", "_massStandard", "_fuelCapacity"
];
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
_angleOfIncidence = getNumber (_class >> "angleOfIndicence"); // config name itself is a typo
if (getNumber (_class >> "flaps") > 0) then {
	_flapsFCoef = getNumber (_class >> "flapsFrictionCoef");
} else {
	_flapsFCoef = 0;
};
if (getNumber (_class >> "gearRetracting") > 0) then {
	_gearsUpFCoef = getNumber (_class >> "gearsUpFrictionCoef");
} else {
	_gearsUpFCoef = 0;
};
if (getNumber (_class >> "airBrake") > 0) then {
	_airBrakeFCoef = getNumber (_class >> "airBrakeFrictionCoef");
} else {
	_airBrakeFCoef = 0;
};
if (isNumber (_class >> "draconicTorqueXCoef")) then {
	_torqueXCoef = getNumber (_class >> "draconicTorqueXCoef");
} else {
	_torqueXCoef = getArray (_class >> "draconicTorqueXCoef");
};

// _speedPerformance
_thrustCoef = getArray (_class >> "thrustCoef");
if !(count _thrustCoef > 0) then {
	_thrustCoef = [1, 1, 1, 1, 1, 0.6666, 0.3333, 0, 0, 0];
};
_vtolMode = getNumber (_class >> "vtol");
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

private _configEnabled = 0;
private _engineData = [1, 1, 1, 1, 1];
private _weightData = [1, 1, 1];
private _miscData = [0, "", ""];
private _codeIntercept = [];
if (isClass (_class >> "AWESome_ConfigData")) then {
	_configEnabled = getNumber (_class >> "AWESome_ConfigData" >> "enabled");

	if (isNumber (_class >> "AWESome_ConfigData" >> "abThrottle")) then {
		_engineData set [0, getNumber (_class >> "AWESome_ConfigData" >> "abThrottle")];
		_engineData set [1, getNumber (_class >> "AWESome_ConfigData" >> "refThrust")];
		_engineData set [2, getNumber (_class >> "AWESome_ConfigData" >> "milThrust")];
		_engineData set [3, getNumber (_class >> "AWESome_ConfigData" >> "abThrust")];
		_engineData set [4, getNumber (_class >> "AWESome_ConfigData" >> "abFuelMultiplier")];
	};

	_weightData set [0, getNumber (_class >> "AWESome_ConfigData" >> "grossWeight")];
	_weightData set [1, getNumber (_class >> "AWESome_ConfigData" >> "zfWeight")];
	_weightData set [2, getNumber (_class >> "AWESome_ConfigData" >> "fuelWeight")];

	_miscData set [0, getNumber (_class >> "AWESome_ConfigData" >> "useExternalFuel")];
	_miscData set [1, getText (_class >> "AWESome_ConfigData" >> "getExternalFuel")];
	_miscData set [2, getText (_class >> "AWESome_ConfigData" >> "setExternalFuel")];

	if (isArray (_class >> "AWESome_ConfigData" >> "codeIntercept")) then {
		_codeIntercept = getArray (_class >> "AWESome_ConfigData" >> "codeIntercept");
	};
};

private _aerodynamicsArray = [_dragArray, _liftArray, _angleOfIncidence, _flapsFCoef, _gearsUpFCoef, _airBrakeFCoef, _torqueXCoef];
private _speedPerformance = [_thrustCoef, _vtolMode, _altFullForce, _altNoForce, _speedStall, _speedMax];
private _physicalProperty = [_massError, _massStandard, _fuelCapacity];
private _configData = [_configEnabled, _engineData, _weightData, _miscData, _codeIntercept];
private _return = [_isAdvanced, _aerodynamicsArray, _speedPerformance, _physicalProperty, _configData];

// report if needed (dev script)
// diag_log format ["orbis_aerodynamics aeroConfig: %1", _return];

_return
