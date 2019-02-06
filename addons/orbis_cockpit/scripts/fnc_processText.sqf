params ["_kias"];

private _kph = _kias * orbis_awesome_knotsToKph;

private _sknots = (str round _kias) + "KIAS";
private _skph = (str round _kph)  + "KPH";

_sknots + " / " + _skph