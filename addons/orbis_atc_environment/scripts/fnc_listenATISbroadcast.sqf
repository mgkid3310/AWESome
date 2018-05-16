private _ATISdata = missionNAmespace getVariable ["orbis_atc_ATIS", false];
private _groundRequired = missionNamespace getVariable ["orbis_atc_gorundATISupdateRequired", false];

if (_groundRequired) then {
    _ATISdata = [false] call orbis_atc_fnc_updateATISdata;
};

if !(_ATISdata isEqualType []) exitWith {};
_ATISdata spawn orbis_atc_fnc_speakATIS;
