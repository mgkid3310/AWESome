#include "script_component.hpp"

params ["_rangeArray", ["_seedArray", [0, 0]]];

if (_rangeArray isEqualType 0) then {_rangeArray = [0, _rangeArray]};
if (_seedArray isEqualType 0) then {_seedArray = [_seedArray, 0]};

if (count _rangeArray isEqualTo 3) exitWith {random _rangeArray};

_rangeArray params ["_rangeMin", "_rangeMax"];
_seedArray params ["_seed1", "_seed2"];

private _newSeed1 = floor (_seed1 random 16777216);
private _newSeed2 = floor (_seed2 random 16777216);

_rangeMin + (([_newSeed1, _newSeed2] call BIS_fnc_bitwiseXOR) random (_rangeMax - _rangeMin))
