private _global = param [0, true];
private _console = param [1, 0];

private _pos = [0, 0, 0];
if (isArray (configFile >> "CfgWorlds" >> worldName >> "ilsPosition")) then {
    _pos = getArray (configFile >> "CfgWorlds" >> worldName >> "ilsPosition");
};
if !(_console isEqualType 0) then {
    _pos = getPos _console;
};
_pos set [2, (getTerrainHeightASL _pos) max 0];

fogParams params ["_fogValue", "_fogDecay", "_fogBase"];
private _fogAltDiff = ((_pos select 2) - _fogBase) max 0;
private _fogApply = _fogValue * (0.5 ^ (_fogAltDiff * _fogDecay / (ln 0.5)));
private _visibility = 10 * exp (-6 * _fogApply);

private _cloudBaseKm = getNumber (configFile >> "CfgWorlds" >> worldName >> "SimulWeather" >> "DefaultKeyframe" >> "cloudBaseKm");
private _cloudHeightKm = getNumber (configFile >> "CfgWorlds" >> worldName >> "SimulWeather" >> "DefaultKeyframe" >> "cloudHeightKm");
private _temperature = (_pos select 2) call ace_weather_fnc_calculateTemperatureAtHeight;
private _humidity = ace_weather_currentHumidity;
private _dewPoint = [_temperature, _humidity] call ace_weather_fnc_calculateDewPoint;
private _QNH = (_pos select 2) call ace_weather_fnc_calculateBarometricPressure;

private _baseArray = [_pos, date];
private _windArray = [windDir, windStr, gusts];
private _visibilityArray = [_visibility, _fogApply];
private _cloudArray = [overcast, _cloudBaseKm, _cloudHeightKm];
private _atmosphereArray = [_temperature, _dewPoint, _QNH];
private _remarksArray = [rain, lightnings];

// [[_pos, _date], [_windDir, _windStr, _gusts], [_visibility, _fogApply], [_overcast, _cloudBaseKm, _cloudHeightKm], [_temperature, _dewPoint, _QNH], [_rain, _lightnings]]
private _ATISdata = [_baseArray, _windArray, _visibilityArray, _cloudArray, _atmosphereArray, _remarksArray];
missionNAmespace setVariable ["orbis_atc_ATIS", _ATISdata, _global];

_ATISdata
