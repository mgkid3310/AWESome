#include "script_component.hpp"

params ["_baseArray", "_windArray", "_visibilityArray", "_cloudArray", "_atmosphereArray", "_remarksArray"];

_baseArray params ["_pos", "_date"];
_windArray params ["_windDir", "_windStr", "_gusts"];
_visibilityArray params ["_visibility", "_fogApply"];
_cloudArray params ["_overcast", "_cloudBaseKm", "_cloudHeightKm"];
_atmosphereArray params ["_hasACEWeather", "_temperature", "_dewPoint", "_QFE"];
_remarksArray params ["_rain", "_lightnings"];

vehicle player setVariable [QGVAR(isATISready), false, true];
vehicle player setVariable [QGVAR(stopATIS), false, true];
vehicle player setVariable [QGVAR(lastATIStime), CBA_missionTime, true];

// time
[format ["orbis_phonetic_%1", floor ((_date select 3) / 10)]] call FUNC(playAndSleep);
[format ["orbis_phonetic_%1", floor ((_date select 3) % 10)]] call FUNC(playAndSleep);
[format ["orbis_phonetic_%1", floor ((_date select 4) / 10)]] call FUNC(playAndSleep);
[format ["orbis_phonetic_%1", floor ((_date select 4) % 10)]] call FUNC(playAndSleep);
["orbis_phonetic_z"] call FUNC(playAndSleep);
["orbis_common_observation"] call FUNC(playAndSleep);

sleep 0.3;

// wind direction
["orbis_common_wind"] call FUNC(playAndSleep);

sleep 0.1;

[format ["orbis_phonetic_%1", floor (_windDir / 100)]] call FUNC(playAndSleep);
[format ["orbis_phonetic_%1", floor ((_windDir % 100) / 10)]] call FUNC(playAndSleep);
[format ["orbis_phonetic_%1", floor (_windDir % 10)]] call FUNC(playAndSleep);

// wind speed
["orbis_common_at"] call FUNC(playAndSleep);
[_windStr] call FUNC(speakNumber);

// gust
/* ["orbis_common_gusting"] call FUNC(playAndSleep);
[_gusts] call FUNC(speakNumber); */

sleep 0.3;

// visibility
["orbis_common_visibility"] call FUNC(playAndSleep);
if (_visibility >= 10) then {
	["orbis_phonetic_1"] call FUNC(playAndSleep);
	["orbis_phonetic_0"] call FUNC(playAndSleep);
} else {
	[_visibility, -1] call FUNC(speakNumber);
};

sleep 0.3;

// cloud
/* ["orbis_common_scattered"] call FUNC(playAndSleep);
["orbis_phonetic_1"] call FUNC(playAndSleep);
["orbis_common_hundred"] call FUNC(playAndSleep);
["orbis_common_broken"] call FUNC(playAndSleep);
["orbis_phonetic_1"] call FUNC(playAndSleep);
["orbis_common_thousand"] call FUNC(playAndSleep);

sleep 0.3; */

if (_hasACEWeather) then {
	// temperature
	["orbis_common_temperature"] call FUNC(playAndSleep);
	[_temperature] call FUNC(speakNumber);

	// dewpoint
	["orbis_common_dewpoint"] call FUNC(playAndSleep);
	[_dewPoint] call FUNC(speakNumber);

	sleep 0.3;

	// altimeter
	["orbis_common_altimeter"] call FUNC(playAndSleep);
	[_QFE] call FUNC(speakNumber);

	sleep 0.3;
};

// remarks
if ((_fogApply > 0) || (!(_overcast < 0.7) && (_rain > 0)) || (!(_overcast < 0.4) && (_lightnings > 0.1))) then {
	["orbis_common_remarks"] call FUNC(playAndSleep);

	// fog
	switch (true) do {
		case (_fogApply > 0.7): {
			sleep 0.3;
			["orbis_common_heavy"] call FUNC(playAndSleep);
			["orbis_common_fog"] call FUNC(playAndSleep);
		};
		case (_fogApply > 0.3): {
			sleep 0.3;
			["orbis_common_fog"] call FUNC(playAndSleep);
		};
		case (_fogApply > 0): {
			sleep 0.3;
			["orbis_common_light"] call FUNC(playAndSleep);
			["orbis_common_fog"] call FUNC(playAndSleep);
		};
	};

	// rain
	if !(_overcast < 0.7) then {
		switch (true) do {
			case (_rain > 0.7): {
				sleep 0.3;
				["orbis_common_heavy"] call FUNC(playAndSleep);
				["orbis_common_rain"] call FUNC(playAndSleep);
			};
			case (_rain > 0.3): {
				sleep 0.3;
				["orbis_common_rain"] call FUNC(playAndSleep);
			};
			case (_rain > 0): {
				sleep 0.3;
				["orbis_common_light"] call FUNC(playAndSleep);
				["orbis_common_rain"] call FUNC(playAndSleep);
			};
		};
	};

	// lightning
	if !(_overcast < 0.4) then {
		switch (true) do {
			case (_lightnings > 0.7): {
				sleep 0.3;
				["orbis_common_heavy"] call FUNC(playAndSleep);
				["orbis_common_lightning"] call FUNC(playAndSleep);
			};
			case (_lightnings > 0.3): {
				sleep 0.3;
				["orbis_common_lightning"] call FUNC(playAndSleep);
			};
			case (_lightnings > 0.1): {
				sleep 0.3;
				["orbis_common_light"] call FUNC(playAndSleep);
				["orbis_common_lightning"] call FUNC(playAndSleep);
			};
		};
	};
};

vehicle player setVariable [QGVAR(isATISready), true, true];
vehicle player setVariable [QGVAR(stopATIS), true, true];
