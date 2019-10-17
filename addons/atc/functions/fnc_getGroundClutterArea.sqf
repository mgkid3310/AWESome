#include "script_component.hpp"

params ["_rAz", "_rEl", "_d", "_height", "_psi"];

if (abs _psi < 1) exitWith {if (_height < _rEl) then {2 * _d * (_rAz / _rEl) * sqrt ((_rEl ^ 2) - (_height ^ 2))} else {0}};
if (abs _psi > 89) exitWith {if (_height < (_d / 2)) then {pi * _rAz * _rEl} else {0}};

private _x0 = _height / sin _psi;
private _x1 = (_x0 - (_d / 2)) * tan _psi;
private _x2 = (_x0 + (_d / 2)) * tan _psi;

private _domainX1 = _rEl min abs _x1;
private _domainX2 = _rEl min abs _x2;

private _S1 = (_rEl ^ 2) * ((pi / 2) - rad acos (_domainX1 / _rEl)) + _domainX1 * sqrt ((_rEl ^ 2) - (_domainX1 ^ 2));
private _S2 = (_rEl ^ 2) * ((pi / 2) - rad acos (_domainX2 / _rEl)) + _domainX2 * sqrt ((_rEl ^ 2) - (_domainX2 ^ 2));

private _A = if ((_x1 * _x2) < 0) then {_S1 + _S2} else {_S1 - _S2};
private _area = _A * (_rAz / _rEl) / sin _psi;

abs _area
