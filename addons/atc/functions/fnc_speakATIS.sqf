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
[format ["awesome_phonetic_%1", floor ((_date select 3) / 10)]] call awesome_atc_fnc_playAndSleep;
[format ["awesome_phonetic_%1", floor ((_date select 3) % 10)]] call awesome_atc_fnc_playAndSleep;
[format ["awesome_phonetic_%1", floor ((_date select 4) / 10)]] call awesome_atc_fnc_playAndSleep;
[format ["awesome_phonetic_%1", floor ((_date select 4) % 10)]] call awesome_atc_fnc_playAndSleep;
["awesome_phonetic_z"] call awesome_atc_fnc_playAndSleep;
["awesome_common_observation"] call awesome_atc_fnc_playAndSleep;

sleep 0.3;

// wind direction
["awesome_common_wind"] call awesome_atc_fnc_playAndSleep;
[format ["awesome_phonetic_%1", floor (_windDir / 100)]] call awesome_atc_fnc_playAndSleep;
[format ["awesome_phonetic_%1", floor ((_windDir % 100) / 10)]] call awesome_atc_fnc_playAndSleep;
[format ["awesome_phonetic_%1", floor (_windDir % 10)]] call awesome_atc_fnc_playAndSleep;

// wind speed
["awesome_common_at"] call awesome_atc_fnc_playAndSleep;
[_windStr] call awesome_atc_fnc_speakNumber;

// gust
/* ["awesome_common_gusting"] call awesome_atc_fnc_playAndSleep;
[_gusts] call awesome_atc_fnc_speakNumber; */

sleep 0.3;

// visibility
["awesome_common_visibility"] call awesome_atc_fnc_playAndSleep;
if (_visibility >= 10) then {
    ["awesome_phonetic_1"] call awesome_atc_fnc_playAndSleep;
    ["awesome_phonetic_0"] call awesome_atc_fnc_playAndSleep;
} else {
    [_visibility, -1] call awesome_atc_fnc_speakNumber;
};

sleep 0.3;

// cloud
/* ["awesome_common_scattered"] call awesome_atc_fnc_playAndSleep;
["awesome_phonetic_1"] call awesome_atc_fnc_playAndSleep;
["awesome_common_hundred"] call awesome_atc_fnc_playAndSleep;
["awesome_common_broken"] call awesome_atc_fnc_playAndSleep;
["awesome_phonetic_1"] call awesome_atc_fnc_playAndSleep;
["awesome_common_thousand"] call awesome_atc_fnc_playAndSleep;

sleep 0.3; */

if (_hasACEWeather) then {
    // temperature
    ["awesome_common_temperature"] call awesome_atc_fnc_playAndSleep;
    [_temperature] call awesome_atc_fnc_speakNumber;

    // dewpoint
    ["awesome_common_dewpoint"] call awesome_atc_fnc_playAndSleep;
    [_dewPoint] call awesome_atc_fnc_speakNumber;

    sleep 0.3;

    // altimeter
    ["awesome_common_altimeter"] call awesome_atc_fnc_playAndSleep;
    [_QFE] call awesome_atc_fnc_speakNumber;

    sleep 0.3;
};

// remarks
if ((_fogApply > 0) || (!(_overcast < 0.7) && (_rain > 0)) || (!(_overcast < 0.4) && (_lightnings > 0.1))) then {
    ["awesome_common_remarks"] call awesome_atc_fnc_playAndSleep;

    // fog
    switch (true) do {
        case (_fogApply > 0.7): {
            sleep 0.1;
            ["awesome_common_heavy"] call awesome_atc_fnc_playAndSleep;
            ["awesome_common_fog"] call awesome_atc_fnc_playAndSleep;
        };
        case (_fogApply > 0.3): {
            sleep 0.1;
            ["awesome_common_fog"] call awesome_atc_fnc_playAndSleep;
        };
        case (_fogApply > 0): {
            sleep 0.1;
            ["awesome_common_light"] call awesome_atc_fnc_playAndSleep;
            ["awesome_common_fog"] call awesome_atc_fnc_playAndSleep;
        };
    };

    // rain
    if !(_overcast < 0.7) then {
        switch (true) do {
            case (_rain > 0.7): {
                sleep 0.1;
                ["awesome_common_heavy"] call awesome_atc_fnc_playAndSleep;
                ["awesome_common_rain"] call awesome_atc_fnc_playAndSleep;
            };
            case (_rain > 0.3): {
                sleep 0.1;
                ["awesome_common_rain"] call awesome_atc_fnc_playAndSleep;
            };
            case (_rain > 0): {
                sleep 0.1;
                ["awesome_common_light"] call awesome_atc_fnc_playAndSleep;
                ["awesome_common_rain"] call awesome_atc_fnc_playAndSleep;
            };
        };
    };

    // lightning
    if !(_overcast < 0.4) then {
        switch (true) do {
            case (_lightnings > 0.7): {
                sleep 0.1;
                ["awesome_common_heavy"] call awesome_atc_fnc_playAndSleep;
                ["awesome_common_lightning"] call awesome_atc_fnc_playAndSleep;
            };
            case (_lightnings > 0.3): {
                sleep 0.1;
                ["awesome_common_lightning"] call awesome_atc_fnc_playAndSleep;
            };
            case (_lightnings > 0.1): {
                sleep 0.1;
                ["awesome_common_light"] call awesome_atc_fnc_playAndSleep;
                ["awesome_common_lightning"] call awesome_atc_fnc_playAndSleep;
            };
        };
    };
};

vehicle player setVariable ["orbisATISready", true, true];
vehicle player setVariable ["orbisATISstop", true, true];
