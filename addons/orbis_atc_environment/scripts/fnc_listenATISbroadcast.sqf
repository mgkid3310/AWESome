private _enabled = missionNamespace getVariable ["orbis_atc_updateATISself", false];
private _ATISdata = missionNAmespace getVariable ["orbis_atc_ATISdata", false];

if (_enabled) then {
    _ATISdata = [false] call orbis_atc_fnc_updateATISdata;
};

if !(_ATISdata isEqualType []) exitWith {};
_ATISdata spawn orbis_atc_fnc_speakATIS;
