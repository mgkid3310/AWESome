params ["_coord", ["_seed", 0]];

if (_coord isEqualType 0) then {
	_coord = [_coord, 0]; // for 1D input, use 2D grid with y=0
};

private _ranges = [];
{
	_ranges pushBack [floor _x, floor _x + 1];
} forEach _coord;

private ["_randomVector", "_vectorMagnitude", "_offsetVector", "_dot"];
private _dotProducts = [];
{
	_randomVector = [];
	_vectorMagnitude = 0;
	_offsetVector = [];
	for "_i" from 0 to (count _coord - 1) do {
		_randomVector pushBack ((((_x select _i) + _seed) random 2) - 1);
		_vectorMagnitude = _vectorMagnitude + ((_randomVector select _i) ^ 2)
		_offsetVector pushBack ((_coord select _i) - (_x select _i));
	};
	if (_vectorMagnitude isEqualTo 0) then {_vectorMagnitude = 1};
	_randomVector = _randomVector apply {_x / sqrt _vectorMagnitude};

	_dot = [];
	for "_i" from 0 to (count _coord - 1) do {
		_dot pushBack ((_randomVector select _i) * (_offsetVector select _i));
	};
	_dotProducts pushBack _dot;
} forEach ([_ranges] call FUNC(combinationProduct));

private ["_interpolated", "_offset", "_smoothStep"];
for "_i" from 0 to (count _coord - 1) do {
	_interpolated = [];
	for "_j" from 0 to ((count _dotProducts / 2) - 1) do {
		_offset = (_coord select _i) - (_ranges select _i select 0);
		_smoothStep = (_offset ^ 2) * (3 - 2 * _offset);
		_interpolated pushBack linearConversion [0, 1, _smoothStep, (_dotProducts select (2 * _j)), (_dotProducts select (2 * _j + 1)), true];
	};
	_dotProducts = _interpolated;
};

_dotProducts select 0
