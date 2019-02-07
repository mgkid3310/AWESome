private _number = _this select 0;
private _minimumPower = param [1, 0];

_number = (10 ^ _minimumPower) * round (_number / (10 ^ _minimumPower));
if (_number < 0) then {
    ["awesome_common_negative"] call awesome_atc_fnc_playAndSleep;
};
_number = abs _number;
for "_i" from ((count str floor abs _number) - 1) to (_minimumPower max 0) step -1 do {
    [format ["awesome_phonetic_%1", floor (((abs _number) % (10 ^ (_i + 1))) / (10 ^ _i))]] call awesome_atc_fnc_playAndSleep;
};
if (_minimumPower < 0) then {
    ["awesome_common_decimal"] call awesome_atc_fnc_playAndSleep;
    for "_i" from -1 to _minimumPower step -1 do {
        [format ["awesome_phonetic_%1", floor (((abs _number) % (10 ^ (_i + 1))) / (10 ^ _i))]] call awesome_atc_fnc_playAndSleep;
    };
};
