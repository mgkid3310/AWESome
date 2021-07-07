#include "script_component.hpp"

params ["_rangeArray", ["_seedArray", [0, 0]]];

if (_rangeArray isEqualType 0) then {_rangeArray = [0, _rangeArray]};
if (_seedArray isEqualType 0) then {_seedArray = [_seedArray, 0]};

_rangeArray params ["_rangeMin", "_rangeMax"];
// _seedArray apply {floor (_x + (_x random 1)) random 64}; // random repeats on seed every 0.64

linearConversion [0, 1, 0 random _seedArray, _rangeMin, _rangeMax];
