#include "script_component.hpp"

params ["_rangeArray", ["_seedArray", [0, 0]]];

if (_rangeArray isEqualType 0) then {_rangeArray = [0, _rangeArray]};
if (_seedArray isEqualType 0) then {_seedArray = [_seedArray, 0]};

if (count _rangeArray isEqualTo 3) exitWith {random _rangeArray};

_rangeArray params ["_rangeMin", "_rangeMax"];
_seedArray params ["_seed", "_salt"];

private _newSeed = floor (_seed random 16777216);
private _newSalt = floor (_salt random 16777216);

_rangeMin + (([_newSeed, _newSalt] call BIS_fnc_bitwiseXOR) random (_rangeMax - _rangeMin))
