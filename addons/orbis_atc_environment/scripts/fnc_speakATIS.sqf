params ["_baseArray", "_windArray", "_visibilityArray", "_cloudArray", "_atmosphereArray", "_remarksArray"];

_baseArray params ["_pos", "_date"];
_windArray params ["_windDir", "_windStr", "_gusts"];
_visibilityArray params ["_visibility", "_fogApply"];
_cloudArray params ["_overcast", "_cloudBaseKm", "_cloudHeightKm"];
_atmosphereArray params ["_hasACEWeather", "_temperature", "_dewPoint", "_QFE"];
_remarksArray params ["_rain", "_lightnings"];

vehicle player setVariable ["orbisATISready", false, true];
vehicle player setVariable ["orbisATISstop", false, true];
vehicle player setVariable ["orbisATISlastTime", CBA_missionTime, true];

// time
[format ["orbis_phonetic_%1", floor ((_date select 3) / 10)]] call orbis_atc_fnc_playAndSleep;
[format ["orbis_phonetic_%1", floor ((_date select 3) % 10)]] call orbis_atc_fnc_playAndSleep;
[format ["orbis_phonetic_%1", floor ((_date select 4) / 10)]] call orbis_atc_fnc_playAndSleep;
[format ["orbis_phonetic_%1", floor ((_date select 4) % 10)]] call orbis_atc_fnc_playAndSleep;
["orbis_phonetic_z"] call orbis_atc_fnc_playAndSleep;
["orbis_common_observation"] call orbis_atc_fnc_playAndSleep;

sleep 0.3;

// wind direction
["orbis_common_wind"] call orbis_atc_fnc_playAndSleep;
[format ["orbis_phonetic_%1", floor (_windDir / 100)]] call orbis_atc_fnc_playAndSleep;
[format ["orbis_phonetic_%1", floor ((_windDir % 100) / 10)]] call orbis_atc_fnc_playAndSleep;
[format ["orbis_phonetic_%1", floor (_windDir % 10)]] call orbis_atc_fnc_playAndSleep;

// wind speed
["orbis_common_at"] call orbis_atc_fnc_playAndSleep;
[_windStr] call orbis_atc_fnc_speakNumber;

// gust
/* ["orbis_common_gusting"] call orbis_atc_fnc_playAndSleep;
[_gusts] call orbis_atc_fnc_speakNumber; */

sleep 0.3;

// visibility
["orbis_common_visibility"] call orbis_atc_fnc_playAndSleep;
if (_visibility >= 10) then {
    ["orbis_phonetic_1"] call orbis_atc_fnc_playAndSleep;
    ["orbis_phonetic_0"] call orbis_atc_fnc_playAndSleep;
} else {
    [_visibility, -1] call orbis_atc_fnc_speakNumber;
};

sleep 0.3;

// cloud
/* ["orbis_common_scattered"] call orbis_atc_fnc_playAndSleep;
["orbis_phonetic_1"] call orbis_atc_fnc_playAndSleep;
["orbis_common_hundred"] call orbis_atc_fnc_playAndSleep;
["orbis_common_broken"] call orbis_atc_fnc_playAndSleep;
["orbis_phonetic_1"] call orbis_atc_fnc_playAndSleep;
["orbis_common_thousand"] call orbis_atc_fnc_playAndSleep;

sleep 0.3; */

if (_hasACEWeather) then {
    // temperature
    ["orbis_common_temperature"] call orbis_atc_fnc_playAndSleep;
    [_temperature] call orbis_atc_fnc_speakNumber;

    // dewpoint
    ["orbis_common_dewpoint"] call orbis_atc_fnc_playAndSleep;
    [_dewPoint] call orbis_atc_fnc_speakNumber;

    sleep 0.3;

    // altimeter
    ["orbis_common_altimeter"] call orbis_atc_fnc_playAndSleep;
    [_QFE] call orbis_atc_fnc_speakNumber;

    sleep 0.3;
};

// remarks
if ((_fogApply isEqualTo 0) && (_rain isEqualTo 0) && (_lightnings isEqualTo 0)) exitWith {
    vehicle player setVariable ["orbisATISready", true];
};
["orbis_common_remarks"] call orbis_atc_fnc_playAndSleep;

// fog
switch (true) do {
    case (_fogApply > 0.7): {
        ["orbis_common_heavy"] call orbis_atc_fnc_playAndSleep;
        ["orbis_common_fog"] call orbis_atc_fnc_playAndSleep;
    };
    case (_fogApply > 0.3): {
        sleep 0.1;
        ["orbis_common_fog"] call orbis_atc_fnc_playAndSleep;
    };
    case (_fogApply > 0): {
        ["orbis_common_light"] call orbis_atc_fnc_playAndSleep;
        ["orbis_common_fog"] call orbis_atc_fnc_playAndSleep;
    };
};

// rain
switch (true) do {
    case (_rain > 0.7): {
        ["orbis_common_heavy"] call orbis_atc_fnc_playAndSleep;
        ["orbis_common_rain"] call orbis_atc_fnc_playAndSleep;
    };
    case (_rain > 0.3): {
        sleep 0.1;
        ["orbis_common_rain"] call orbis_atc_fnc_playAndSleep;
    };
    case (_rain > 0): {
        ["orbis_common_light"] call orbis_atc_fnc_playAndSleep;
        ["orbis_common_rain"] call orbis_atc_fnc_playAndSleep;
    };
};

// lightning
switch (true) do {
    case (_lightnings > 0.7): {
        ["orbis_common_heavy"] call orbis_atc_fnc_playAndSleep;
        ["orbis_common_lightning"] call orbis_atc_fnc_playAndSleep;
    };
    case (_lightnings > 0.3): {
        sleep 0.1;
        ["orbis_common_lightning"] call orbis_atc_fnc_playAndSleep;
    };
    case (_lightnings > 0): {
        ["orbis_common_light"] call orbis_atc_fnc_playAndSleep;
        ["orbis_common_lightning"] call orbis_atc_fnc_playAndSleep;
    };
};

vehicle player setVariable ["orbisATISready", true, true];
vehicle player setVariable ["orbisATISstop", true, true];
