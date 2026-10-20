#include "script_component.hpp"

params ["_altitude", "_temperatureSL"];

private ["_altitudeBase", "_pressureBase", "_temperatureStd", "_temperatureLR", "_temperature"];
private _temperatureISA = 15;
_altitude = _altitude min 120000;

// scale upper layer base pressures so that pressure stays continuous at the tropopause with non-standard sea level temperature
private _temperatureSLK = _temperatureSL + 273.15;
private _temperatureTropoK = _temperatureISA + 201.65;
private _lapseRateTropo = (_temperatureTropoK - _temperatureSLK) / 11000;
private _pressureRatioTropo = if (abs _lapseRateTropo < 0.000001) then {
	exp (-0.0341632 * 11000 / _temperatureSLK)
} else {
	(_temperatureSLK / _temperatureTropoK) ^ (0.0341632 / _lapseRateTropo) // g * M / R = 0.0341632
};
private _pressureScale = 1013.25 * _pressureRatioTropo / 226.321;

switch (true) do {
	// subscript 0
	case (_altitude < 11000): {
		_altitudeBase = 0;
		_pressureBase = 1013.25; // hPa
		_temperatureStd = _temperatureSLK; // Kelvin
		_temperatureLR = _lapseRateTropo;
		_temperature = _temperatureStd + _temperatureLR * _altitude;
	};

	// subscript 1
	case (_altitude < 20000): {
		_altitudeBase = 11000;
		_pressureBase = 226.321 * _pressureScale;
		_temperatureStd = _temperatureISA + 201.65;
		_temperatureLR = 0;
		_temperature = _temperatureStd;
	};

	// subscript 2
	case (_altitude < 32000): {
		_altitudeBase = 20000;
		_pressureBase = 54.7489 * _pressureScale;
		_temperatureStd = _temperatureISA + 201.65;
		_temperatureLR = 0.001;
		_temperature = _temperatureStd + _temperatureLR * (_altitude - _altitudeBase);
	};

	// subscript 3
	case (_altitude < 47000): {
		_altitudeBase = 32000;
		_pressureBase = 8.6802 * _pressureScale;
		_temperatureStd = _temperatureISA + 213.65;
		_temperatureLR = 0.0028;
		_temperature = _temperatureStd + _temperatureLR * (_altitude - _altitudeBase);
	};

	// subscript 4
	case (_altitude < 51000): {
		_altitudeBase = 47000;
		_pressureBase = 1.1091 * _pressureScale;
		_temperatureStd = _temperatureISA + 255.65;
		_temperatureLR = 0;
		_temperature = _temperatureStd;
	};

	// subscript 5
	case (_altitude < 71000): {
		_altitudeBase = 51000;
		_pressureBase = 0.6694 * _pressureScale;
		_temperatureStd = _temperatureISA + 255.65;
		_temperatureLR = -0.0028;
		_temperature = _temperatureStd + _temperatureLR * (_altitude - _altitudeBase);
	};

	// subscript 6
	default {
		_altitudeBase = 71000;
		_pressureBase = 0.0396 * _pressureScale;
		_temperatureStd = _temperatureISA + 199.65;
		_temperatureLR = -0.002;
		_temperature = _temperatureStd + _temperatureLR * (_altitude - _altitudeBase);
	};
};

[_altitudeBase, _pressureBase, (_temperatureStd max 0) - 273.15, _temperatureLR, (_temperature max 0) - 273.15]
