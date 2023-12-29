#include "script_component.hpp"

params ["_vehicle", "_ATISdata", ["_mode", 0], ["_noSound", false]];
_ATISdata params ["_baseArray", "_windArray", "_visibilityArray", "_cloudArray", "_atmosphereArray", "_remarksArray"];

_baseArray params ["_identifier", "_time", "_date", "_pos"];
_windArray params ["_windDir", "_windStr", "_gusting"];
_visibilityArray params ["_visibility", "_fogApply"];
_cloudArray params ["_overcast", "_cloudBaseKm", "_cloudHeightKm"];
_atmosphereArray params ["_hasACEWeather", "_temperature", "_dewPoint", "_QNH"];
_remarksArray params ["_rain", "_lightnings"];

_vehicle setVariable [QGVAR(isATISready), false];
_vehicle setVariable [QGVAR(stopATIS), false];
_vehicle setVariable [QGVAR(lastATIStime), CBA_missionTime];

private _textATIS = "";

// identifier
if (_identifier != "") then {
	_textATIS = [_vehicle, "orbis_common_information", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
	_textATIS = [_vehicle, format ["orbis_phonetic_%1", toLower _identifier], _mode, _noSound, _textATIS] call FUNC(playAndSleep);

	ATIS_SLEEP(0.3)
};

// time
_textATIS = [_vehicle, format ["orbis_phonetic_%1", floor ((_date select 3) / 10)], _mode, _noSound, _textATIS, false] call FUNC(playAndSleep);
_textATIS = [_vehicle, format ["orbis_phonetic_%1", floor ((_date select 3) % 10)], _mode, _noSound, _textATIS, false] call FUNC(playAndSleep);
_textATIS = [_vehicle, format ["orbis_phonetic_%1", floor ((_date select 4) / 10)], _mode, _noSound, _textATIS, false] call FUNC(playAndSleep);
_textATIS = [_vehicle, format ["orbis_phonetic_%1", floor ((_date select 4) % 10)], _mode, _noSound, _textATIS, false] call FUNC(playAndSleep);
_textATIS = [_vehicle, "orbis_phonetic_z", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
_textATIS = [_vehicle, "orbis_common_observation", _mode, _noSound, _textATIS] call FUNC(playAndSleep);

ATIS_SLEEP(0.3)

// wind direction
_textATIS = [_vehicle, "orbis_common_wind", _mode, _noSound, _textATIS] call FUNC(playAndSleep);

ATIS_SLEEP(0.1)

_textATIS = [_vehicle, format ["orbis_phonetic_%1", floor (_windDir / 100)], _mode, _noSound, _textATIS, false] call FUNC(playAndSleep);
_textATIS = [_vehicle, format ["orbis_phonetic_%1", floor ((_windDir % 100) / 10)], _mode, _noSound, _textATIS, false] call FUNC(playAndSleep);
_textATIS = [_vehicle, format ["orbis_phonetic_%1", floor (_windDir % 10)], _mode, _noSound, _textATIS, false] call FUNC(playAndSleep);
_textATIS = _textATIS + '° ';

// wind speed
_textATIS = [_vehicle, "orbis_common_at", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
_textATIS = [_vehicle, _windStr, 0, _mode, _noSound, _textATIS, false] call FUNC(speakNumber);
_textATIS = _textATIS + 'kt ';

// gust
if (((_gusting > 1.5 * _windStr) && (_gusting > _windStr + 3)) || (_gusting > _windStr + 10)) then {
	_textATIS = [_vehicle, "orbis_common_gusting", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
	_textATIS = [_vehicle, _gusting, 0, _mode, _noSound, _textATIS, false] call FUNC(speakNumber);
	_textATIS = _textATIS + 'kt ';
};

ATIS_SLEEP(0.3)

// visibility
_textATIS = [_vehicle, "orbis_common_visibility", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
if (_visibility >= 10) then {
	_textATIS = [_vehicle, "orbis_phonetic_1", _mode, _noSound, _textATIS, false] call FUNC(playAndSleep);
	_textATIS = [_vehicle, "orbis_phonetic_0", _mode, _noSound, _textATIS, false] call FUNC(playAndSleep);
	_textATIS = _textATIS + 'km or more ';
} else {
	_textATIS = [_vehicle, _visibility, -1, _mode, _noSound, _textATIS, false] call FUNC(speakNumber);
	_textATIS = _textATIS + 'km ';
};

ATIS_SLEEP(0.3)

// cloud
/* _textATIS = [_vehicle, "orbis_common_scattered", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
_textATIS = [_vehicle, "orbis_phonetic_1", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
_textATIS = [_vehicle, "orbis_common_hundred", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
_textATIS = [_vehicle, "orbis_common_broken", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
_textATIS = [_vehicle, "orbis_phonetic_1", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
_textATIS = [_vehicle, "orbis_common_thousand", _mode, _noSound, _textATIS] call FUNC(playAndSleep);

ATIS_SLEEP(0.3) */

if (_hasACEWeather) then {
	// temperature
	_textATIS = [_vehicle, "orbis_common_temperature", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
	_textATIS = [_vehicle, _temperature, 0, _mode, _noSound, _textATIS, false] call FUNC(speakNumber);
	_textATIS = _textATIS + '°C ';

	// dewpoint
	_textATIS = [_vehicle, "orbis_common_dewpoint", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
	_textATIS = [_vehicle, _dewPoint, 0, _mode, _noSound, _textATIS, false] call FUNC(speakNumber);
	_textATIS = _textATIS + '°C ';

	ATIS_SLEEP(0.3)

	// altimeter
	_textATIS = [_vehicle, "orbis_common_altimeter", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
	_textATIS = [_vehicle, _QNH, 0, _mode, _noSound, _textATIS, false] call FUNC(speakNumber);
	_textATIS = _textATIS + 'hPa ';

	ATIS_SLEEP(0.3)
};

// remarks
if ((_fogApply > 0) || (!(_overcast < 0.7) && (_rain > 0)) || (!(_overcast < 0.4) && (_lightnings > 0.1))) then {
	_textATIS = [_vehicle, "orbis_common_remarks", _mode, _noSound, _textATIS] call FUNC(playAndSleep);

	// fog
	switch (true) do {
		case (_fogApply > 0.7): {
			ATIS_SLEEP(0.2)
			_textATIS = [_vehicle, "orbis_common_heavy", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
			_textATIS = [_vehicle, "orbis_common_fog", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
		};
		case (_fogApply > 0.3): {
			ATIS_SLEEP(0.2)
			_textATIS = [_vehicle, "orbis_common_fog", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
		};
		case (_fogApply > 0): {
			ATIS_SLEEP(0.2)
			_textATIS = [_vehicle, "orbis_common_light", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
			_textATIS = [_vehicle, "orbis_common_fog", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
		};
	};

	// rain
	if !(_overcast < 0.7) then {
		switch (true) do {
			case (_rain > 0.7): {
				ATIS_SLEEP(0.2)
				_textATIS = [_vehicle, "orbis_common_heavy", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
				_textATIS = [_vehicle, "orbis_common_rain", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
			};
			case (_rain > 0.3): {
				ATIS_SLEEP(0.2)
				_textATIS = [_vehicle, "orbis_common_rain", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
			};
			case (_rain > 0): {
				ATIS_SLEEP(0.2)
				_textATIS = [_vehicle, "orbis_common_light", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
				_textATIS = [_vehicle, "orbis_common_rain", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
			};
		};
	};

	// lightning
	if !(_overcast < 0.4) then {
		switch (true) do {
			case (_lightnings > 0.7): {
				ATIS_SLEEP(0.2)
				_textATIS = [_vehicle, "orbis_common_heavy", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
				_textATIS = [_vehicle, "orbis_common_lightning", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
			};
			case (_lightnings > 0.3): {
				ATIS_SLEEP(0.2)
				_textATIS = [_vehicle, "orbis_common_lightning", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
			};
			case (_lightnings > 0.1): {
				ATIS_SLEEP(0.2)
				_textATIS = [_vehicle, "orbis_common_light", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
				_textATIS = [_vehicle, "orbis_common_lightning", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
			};
		};
	};

	ATIS_SLEEP(0.3)
};

// advise
if (_identifier != "") then {
	_textATIS = [_vehicle, "orbis_phrase_advise", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
	_textATIS = [_vehicle, "orbis_common_information", _mode, _noSound, _textATIS] call FUNC(playAndSleep);
	_textATIS = [_vehicle, format ["orbis_phonetic_%1", toLower _identifier], _mode, _noSound, _textATIS] call FUNC(playAndSleep);
};

_vehicle setVariable [QGVAR(isATISready), true];
_vehicle setVariable [QGVAR(stopATIS), true];

_textATIS;
