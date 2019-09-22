#include "script_component.hpp"

params ["_vehicle", "_number", ["_minimumPower", 0], ["_mode", 0]];

_number = (10 ^ _minimumPower) * round (_number / (10 ^ _minimumPower));
if (_number < 0) then {
	[_vehicle, "orbis_common_negative", _mode] call FUNC(playAndSleep);
};
_number = abs _number;
for "_i" from ((count str floor abs _number) - 1) to (_minimumPower max 0) step -1 do {
	[_vehicle, format ["orbis_phonetic_%1", floor (((abs _number) % (10 ^ (_i + 1))) / (10 ^ _i))], _mode] call FUNC(playAndSleep);
};
if (_minimumPower < 0) then {
	[_vehicle, "orbis_common_decimal", _mode] call FUNC(playAndSleep);
	for "_i" from -1 to _minimumPower step -1 do {
		[_vehicle, format ["orbis_phonetic_%1", floor (((abs _number) % (10 ^ (_i + 1))) / (10 ^ _i))], _mode] call FUNC(playAndSleep);
	};
};
