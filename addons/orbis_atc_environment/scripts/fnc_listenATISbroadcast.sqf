private _ATISdata = missionNAmespace getVariable ["orbis_atc_ATIS", false];

if !(_ATISdata isEqualType []) exitWith {};
_ATISdata spawn orbis_atc_fnc_speakATIS;
