#include "script_component.hpp"

params ["_vehicle", "_ATISdata", ["_mode", 0]];
_ATISdata params ["_baseArray", "_windArray", "_visibilityArray", "_cloudArray", "_atmosphereArray", "_remarksArray"];

_baseArray params ["_pos", "_date"];
_windArray params ["_windDir", "_windStr", "_gusts"];
_visibilityArray params ["_visibility", "_fogApply"];
_cloudArray params ["_overcast", "_cloudBaseKm", "_cloudHeightKm"];
_atmosphereArray params ["_hasACEWeather", "_temperature", "_dewPoint", "_QFE"];
_remarksArray params ["_rain", "_lightnings"];

_vehicle setVariable [QGVAR(isATISready), false];
_vehicle setVariable [QGVAR(stopATIS), false];
_vehicle setVariable [QGVAR(lastATIStime), CBA_missionTime];

// time
[_vehicle, format ["orbis_phonetic_%1", floor ((_date select 3) / 10)], _mode] call FUNC(playAndSleep);
[_vehicle, format ["orbis_phonetic_%1", floor ((_date select 3) % 10)], _mode] call FUNC(playAndSleep);
[_vehicle, format ["orbis_phonetic_%1", floor ((_date select 4) / 10)], _mode] call FUNC(playAndSleep);
[_vehicle, format ["orbis_phonetic_%1", floor ((_date select 4) % 10)], _mode] call FUNC(playAndSleep);
[_vehicle, "orbis_phonetic_z", _mode] call FUNC(playAndSleep);
[_vehicle, "orbis_common_observation", _mode] call FUNC(playAndSleep);

ATIS_SLEEP(0.3)

// wind direction
[_vehicle, "orbis_common_wind", _mode] call FUNC(playAndSleep);

ATIS_SLEEP(0.1)

[_vehicle, format ["orbis_phonetic_%1", floor (_windDir / 100)], _mode] call FUNC(playAndSleep);
[_vehicle, format ["orbis_phonetic_%1", floor ((_windDir % 100) / 10)], _mode] call FUNC(playAndSleep);
[_vehicle, format ["orbis_phonetic_%1", floor (_windDir % 10)], _mode] call FUNC(playAndSleep);

// wind speed
[_vehicle, "orbis_common_at", _mode] call FUNC(playAndSleep);
[_vehicle, _windStr, 0, _mode] call FUNC(speakNumber);

// gust
/* [_vehicle, "orbis_common_gusting", _mode] call FUNC(playAndSleep);
[_vehicle, _gusts, 0, _mode] call FUNC(speakNumber); */

ATIS_SLEEP(0.3)

// visibility
[_vehicle, "orbis_common_visibility", _mode] call FUNC(playAndSleep);
if (_visibility >= 10) then {
	[_vehicle, "orbis_phonetic_1", _mode] call FUNC(playAndSleep);
	[_vehicle, "orbis_phonetic_0", _mode] call FUNC(playAndSleep);
} else {
	[_vehicle, _visibility, -1, _mode] call FUNC(speakNumber);
};

ATIS_SLEEP(0.3)

// cloud
/* [_vehicle, "orbis_common_scattered", _mode] call FUNC(playAndSleep);
[_vehicle, "orbis_phonetic_1", _mode] call FUNC(playAndSleep);
[_vehicle, "orbis_common_hundred", _mode] call FUNC(playAndSleep);
[_vehicle, "orbis_common_broken", _mode] call FUNC(playAndSleep);
[_vehicle, "orbis_phonetic_1", _mode] call FUNC(playAndSleep);
[_vehicle, "orbis_common_thousand", _mode] call FUNC(playAndSleep);

ATIS_SLEEP(0.3) */

if (_hasACEWeather) then {
	// temperature
	[_vehicle, "orbis_common_temperature", _mode] call FUNC(playAndSleep);
	[_vehicle, _temperature, 0, _mode] call FUNC(speakNumber);

	// dewpoint
	[_vehicle, "orbis_common_dewpoint", _mode] call FUNC(playAndSleep);
	[_vehicle, _dewPoint, 0, _mode] call FUNC(speakNumber);

	ATIS_SLEEP(0.3)

	// altimeter
	[_vehicle, "orbis_common_altimeter", _mode] call FUNC(playAndSleep);
	[_vehicle, _QFE, 0, _mode] call FUNC(speakNumber);

	ATIS_SLEEP(0.3)
};

// remarks
if ((_fogApply > 0) || (!(_overcast < 0.7) && (_rain > 0)) || (!(_overcast < 0.4) && (_lightnings > 0.1))) then {
	[_vehicle, "orbis_common_remarks", _mode] call FUNC(playAndSleep);

	// fog
	switch (true) do {
		case (_fogApply > 0.7): {
			ATIS_SLEEP(0.2)
			[_vehicle, "orbis_common_heavy", _mode] call FUNC(playAndSleep);
			[_vehicle, "orbis_common_fog", _mode] call FUNC(playAndSleep);
		};
		case (_fogApply > 0.3): {
			ATIS_SLEEP(0.2)
			[_vehicle, "orbis_common_fog", _mode] call FUNC(playAndSleep);
		};
		case (_fogApply > 0): {
			ATIS_SLEEP(0.2)
			[_vehicle, "orbis_common_light", _mode] call FUNC(playAndSleep);
			[_vehicle, "orbis_common_fog", _mode] call FUNC(playAndSleep);
		};
	};

	// rain
	if !(_overcast < 0.7) then {
		switch (true) do {
			case (_rain > 0.7): {
				ATIS_SLEEP(0.2)
				[_vehicle, "orbis_common_heavy", _mode] call FUNC(playAndSleep);
				[_vehicle, "orbis_common_rain", _mode] call FUNC(playAndSleep);
			};
			case (_rain > 0.3): {
				ATIS_SLEEP(0.2)
				[_vehicle, "orbis_common_rain", _mode] call FUNC(playAndSleep);
			};
			case (_rain > 0): {
				ATIS_SLEEP(0.2)
				[_vehicle, "orbis_common_light", _mode] call FUNC(playAndSleep);
				[_vehicle, "orbis_common_rain", _mode] call FUNC(playAndSleep);
			};
		};
	};

	// lightning
	if !(_overcast < 0.4) then {
		switch (true) do {
			case (_lightnings > 0.7): {
				ATIS_SLEEP(0.2)
				[_vehicle, "orbis_common_heavy", _mode] call FUNC(playAndSleep);
				[_vehicle, "orbis_common_lightning", _mode] call FUNC(playAndSleep);
			};
			case (_lightnings > 0.3): {
				ATIS_SLEEP(0.2)
				[_vehicle, "orbis_common_lightning", _mode] call FUNC(playAndSleep);
			};
			case (_lightnings > 0.1): {
				ATIS_SLEEP(0.2)
				[_vehicle, "orbis_common_light", _mode] call FUNC(playAndSleep);
				[_vehicle, "orbis_common_lightning", _mode] call FUNC(playAndSleep);
			};
		};
	};
};

_vehicle setVariable [QGVAR(isATISready), true];
_vehicle setVariable [QGVAR(stopATIS), true];
