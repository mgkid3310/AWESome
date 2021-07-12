#include "script_component.hpp"

params [["_range", 1], ["_seed", systemTime select 6], ["_parameter", []]];

private _modulus = _parameter param [0, 2147483647]; // MINSTD 1993, 2^31 - 1 (M_31)
private _multiplier = _parameter param [1, 48271]; // MINSTD 1993
private _increment = _parameter param [2, 0]; // MINSTD 1993
private _repeat = _parameter param [3, 4];

// private _random = floor _seed;
// private _decimal = _seed % 1;
private _random = _seed;

for "_i" from 1 to _repeat do {
	_random = _random * _multiplier;
	_random = _random + _increment;
	_random = _random % _modulus;
};

_range * _random / _modulus
