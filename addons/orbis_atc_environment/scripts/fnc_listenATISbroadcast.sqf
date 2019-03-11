private _ATISdata = missionNAmespace getVariable ["orbis_atc_ATISdata", false];

if (orbis_atc_realtimeATIS) then {
    _ATISdata = [false] call orbis_atc_fnc_updateATISdata;
};

if !(_ATISdata isEqualType []) exitWith {};
_ATISdata spawn orbis_atc_fnc_speakATIS;
