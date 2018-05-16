private _ATISdata = missionNAmespace getVariable ["orbis_atc_ATIS", false];
private _enabled = missionNamespace getVariable ["orbis_atc_updateATISself", false];

if (_enabled) then {
    _ATISdata = [false] call orbis_atc_fnc_updateATISdata;
};

if !(_ATISdata isEqualType []) exitWith {};
_ATISdata spawn orbis_atc_fnc_speakATIS;
