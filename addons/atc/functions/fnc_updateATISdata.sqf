#include "script_component.hpp"

params [["_isPublic", false], ["_withIdentifier", true], ["_console", 0]];

private ["_identifier"];
if (_withIdentifier) then {
	_identifier = (missionNamespace getVariable [QGVAR(ATISdata), [[""]]]) select 0 select 0;
	_identifier = [_identifier, 1] call FUNC(getIdentifier);
} else {
	_identifier = "";
};

private _pos = [0, 0, 0];
if (isArray (configFile >> "CfgWorlds" >> worldName >> "ilsPosition")) then {
	_pos = getArray (configFile >> "CfgWorlds" >> worldName >> "ilsPosition");
};
if !(_console isEqualType 0) then {
	_pos = getPos _console;
};
_pos set [2, ((getTerrainHeightASL _pos) max 0) + 1];

private ["_windSimulated", "_windDir", "_windStr", "_gusting"];
if (isClass (configFile >> "CfgPatches" >> "orbis_aerodynamics")) then {
	_windSimulated = [_pos, 0] call EFUNC(aerodynamics,getWindPosASL);
	_windSimulated set [2, 0];

	_windDir = _windSimulated getDir [0, 0, 0];
	_windStr = (vectorMagnitude _windSimulated) * (900 / 463);
	_gusting = _windStr * (1 + gusts * EGVAR(aerodynamics,gustMultiplier) / 2);

	// systemChat str [_pos, getTerrainHeightASL _pos, wind, _windSimulated, _windDir, _windStr];
} else {
	_windDir = (windDir + 180) % 360;
	_windStr = (vectorMagnitude wind) * (900 / 463);
	_gusting = _windStr;
};

fogParams params ["_fogValue", "_fogDecay", "_fogBase"];
private _fogAltDiff = ((_pos select 2) - _fogBase) max 0;
private _fogApply = _fogValue * (0.5 ^ (_fogAltDiff * _fogDecay / (ln 0.5)));
private _visibility = 10 * exp (-6 * _fogApply);

private _cloudBaseKm = getNumber (configFile >> "CfgWorlds" >> worldName >> "SimulWeather" >> "DefaultKeyframe" >> "cloudBaseKm");
private _cloudHeightKm = getNumber (configFile >> "CfgWorlds" >> worldName >> "SimulWeather" >> "DefaultKeyframe" >> "cloudHeightKm");

private _temperature = 0;
private _humidity = 0;
private _dewPoint = 0;
private _QNH = 0;
if (EGVAR(main,hasACEWeather)) then {
	_temperature = (_pos select 2) call ace_weather_fnc_calculateTemperatureAtHeight;
	_humidity = ace_weather_currentHumidity;
	_dewPoint = [_temperature, _humidity] call ace_weather_fnc_calculateDewPoint;
	_QNH = 0 call ace_weather_fnc_calculateBarometricPressure;
};

private _baseArray = [_identifier, CBA_missionTime, date, _pos];
private _windArray = [_windDir, _windStr, _gusting];
private _visibilityArray = [_visibility, _fogApply];
private _cloudArray = [overcast, _cloudBaseKm, _cloudHeightKm];
private _atmosphereArray = [EGVAR(main,hasACEWeather), _temperature, _dewPoint, _QNH];
private _remarksArray = [rain, lightnings];

// [[_identifier, _time, _date, _pos], [_windDir, _windStr, _gusts], [_visibility, _fogApply], [_overcast, _cloudBaseKm, _cloudHeightKm], [_hasACEWeather, _temperature, _dewPoint, _QNH], [_rain, _lightnings]]
private _ATISdata = [_baseArray, _windArray, _visibilityArray, _cloudArray, _atmosphereArray, _remarksArray];
missionNamespace setVariable [QGVAR(ATISdata), _ATISdata, _isPublic];

_ATISdata
