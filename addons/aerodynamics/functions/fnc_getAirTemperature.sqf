#include "script_component.hpp"

params ["_altitude", "_temperatureSL"];

private ["_altitudeBase", "_pressureBase", "_temperatureStd", "_temperatureLR", "_temperature"];
private _temperatureSATP= 25;
_altitude = _altitude min 120000;
switch (true) do {
	// subscript 0
	case (_altitude < 11000): {
		_altitudeBase = 0;
		_pressureBase = 1013.25; // hPa
		_temperatureStd = _temperatureSL + 273.15; // Kelvin
		_temperatureLR = (_temperatureSATP - _temperatureSL - 71.5) / 11000;
		_temperature = _temperatureStd + _temperatureLR * _altitude;
	};

	// subscript 1
	case (_altitude < 20000): {
		_altitudeBase = 11000;
		_pressureBase = 226.321;
		_temperatureStd = _temperatureSATP + 201.65;
		_temperatureLR = 0;
		_temperature = _temperatureStd;
	};

	// subscript 2
	case (_altitude < 32000): {
		_altitudeBase = 20000;
		_pressureBase = 54.7489;
		_temperatureStd = _temperatureSATP + 201.65;
		_temperatureLR = 0.001;
		_temperature = _temperatureStd + _temperatureLR * (_altitude - _altitudeBase);
	};

	// subscript 3
	case (_altitude < 47000): {
		_altitudeBase = 32000;
		_pressureBase = 8.6802;
		_temperatureStd = _temperatureSATP + 213.65;
		_temperatureLR = 0.0028;
		_temperature = _temperatureStd + _temperatureLR * (_altitude - _altitudeBase);
	};

	// subscript 4
	case (_altitude < 51000): {
		_altitudeBase = 47000;
		_pressureBase = 1.1091;
		_temperatureStd = _temperatureSATP + 255.65;
		_temperatureLR = 0;
		_temperature = _temperatureStd;
	};

	// subscript 5
	case (_altitude < 71000): {
		_altitudeBase = 51000;
		_pressureBase = 0.6694;
		_temperatureStd = _temperatureSATP + 255.65;
		_temperatureLR = -0.0028;
		_temperature = _temperatureStd + _temperatureLR * (_altitude - _altitudeBase);
	};

	// subscript 6
	default {
		_altitudeBase = 71000;
		_pressureBase = 0.0396;
		_temperatureStd = _temperatureSATP + 199.65;
		_temperatureLR = -0.002;
		_temperature = _temperatureStd + _temperatureLR * (_altitude - _altitudeBase);
	};
};

[_altitudeBase, _pressureBase, (_temperatureStd max 0) - 273.15, _temperatureLR, (_temperature max 0) - 273.15]
