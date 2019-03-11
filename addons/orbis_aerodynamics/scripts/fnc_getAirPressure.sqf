params ["_altitude", "_temperatureArray", "_pressureSL"];
_temperatureArray params ["_altitudeBase", "_pressureBase", "_temperatureStd", "_temperatureLR", "_temperature"];

private ["_base", "_power"];
_altitude = _altitude min 120000;
_temperatureStd = _temperatureStd + 273.15;
_temperature = _temperature + 273.15;
if !(_temperatureLR isEqualTo 0) then {
	_base = _temperatureStd / _temperature;
	_power = (9.80665 * 0.0289644) / (8.3144598 * _temperatureLR);
} else {
	_base = 2.71828182846;
	_power = -(9.80665 * 0.0289644 * (_altitude - _altitudeBase)) / (8.3144598 * _temperatureStd);
};

private _pressure = _pressureBase * (_pressureSL / 1013.25) * (_base ^ _power); // hPa

_pressure
