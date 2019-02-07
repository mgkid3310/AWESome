private _ATISdata = missionNAmespace getVariable ["awesome_atc_ATIS", false];
private _enabled = missionNamespace getVariable ["awesome_atc_updateATISself", false];

if (_enabled) then {
    _ATISdata = [false] call awesome_atc_fnc_updateATISdata;
};

if !(_ATISdata isEqualType []) exitWith {};
_ATISdata spawn awesome_atc_fnc_speakATIS;
