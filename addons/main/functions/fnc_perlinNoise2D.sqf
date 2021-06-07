params ["_coord", ["_seed", 0]];

if (_coord isEqualType 0) then {
	_coord = [_coord, 0]; // for 1D input, use 2D grid with y=0
};

private _ranges = [];
{
	_ranges pushBack [floor _x, floor _x + 1];
} forEach _coord;

private ["_product", "_vector"];
private _corners = [];
for "_i" from 1 to count _coord do {
	for "_j" from 1 to count _coord do {
		_product = [_ranges select _i select 0, _ranges select _j select 1];
		_vector = vectorNormalized [(_product select 0) random 1, (_product select 1) random 1];
		_corners pushBack [_product, _vector];
	};
};

{
	(_x select 0) vectorDiff _coord;
} forEach _corners;
