params ["_range", "_azimuthBandwith", "_pulseWidth", "_height", "_psi"];

private _r = _range * tan (_azimuthBandwith / 2);
private _d = _pulseWidth * GVAR(speedOfLight) / 2;

if (abs _psi < 1) exitWith {2 * _r * _d};
if (abs _psi > 89) exitWith {if (_height < (_d / 2)) then {pi * (_r ^ 2)} else {0}};

private _x0 = _height / sin _psi;
private _x1 = (_x0 - (_d / 2)) * tan _psi;
private _x2 = (_x0 + (_d / 2)) * tan _psi;

private _S1 = 2 * (_r ^ 2) * acos (abs _x1 / _r) - abs _x1 * sqrt ((_r ^ 2) - (_x1 ^ 2));
private _S2 = 2 * (_r ^ 2) * acos (abs _x2 / _r) - abs _x2 * sqrt ((_r ^ 2) - (_x2 ^ 2));

private _A = if ((_x1 * _x2) < 0) then {_S1 + _S2} else {_S1 - _S2};
private _area = ((sin _psi) / ((cos _psi) ^ 2)) * abs _A;

_area
