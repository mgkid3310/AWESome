#include "script_component.hpp"

params ["_vehicle", "_number", ["_minimumPower", 0], ["_mode", 0], ["_noSound", False], ["_text", 0], ["_addSpace", True]];

_number = (10 ^ _minimumPower) * round (_number / (10 ^ _minimumPower));
if (_number < 0) then {
	_text = [_vehicle, "orbis_common_negative", _mode, _noSound, _text, False] call FUNC(playAndSleep);
};
_number = abs _number;
for "_i" from ((count str floor abs _number) - 1) to (_minimumPower max 0) step -1 do {
	_text = [_vehicle, format ["orbis_phonetic_%1", floor (((abs _number) % (10 ^ (_i + 1))) / (10 ^ _i))], _mode, _noSound, _text, False] call FUNC(playAndSleep);
};
if (_minimumPower < 0) then {
	_text = [_vehicle, "orbis_common_decimal", _mode, _noSound, _text, False] call FUNC(playAndSleep);
	for "_i" from -1 to _minimumPower step -1 do {
		_text = [_vehicle, format ["orbis_phonetic_%1", floor (((abs _number) % (10 ^ (_i + 1))) / (10 ^ _i))], _mode, _noSound, _text, False] call FUNC(playAndSleep);
	};
};

if (_text isEqualType "") then {
	if (_addSpace) then {
		_text = _text + " ";
	};
};

_text
