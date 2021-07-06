#include "script_component.hpp"

params ["_rangeArray", ["_seedArray", [0, 0]]];

if (_rangeArray isEqualType 0) then {_rangeArray = [0, _rangeArray]};
if (_seedArray isEqualType 0) then {_seedArray = [_seedArray, 0]};

_rangeArray params ["_rangeMin", "_rangeMax"];
_seedArray params ["_seed1", "_seed2"];

// _rangeMin + (random [_seed1 random 32, _seed2 random 32] random (_rangeMax - _rangeMin))
linearConversion [0, 1, 0 random [_seed1 random 32, _seed2 random 32], _rangeMin, _rangeMax];
