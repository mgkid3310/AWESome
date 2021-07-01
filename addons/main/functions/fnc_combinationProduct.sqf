#include "script_component.hpp"

params ["_list", ["_indexes", []]];

private _products = [];
if (count _list > count _indexes) then {
	for "_i" from 0 to (count (_list select count _indexes) - 1) do {
		_products append ([_list, _indexes + [_i]] call FUNC(combinatnionProduct));
	};
} else {
	{
		_products pushBack ((_list select _forEachIndex) select _x);
	} forEach _indexes;

	_products = [_products];
};

_products
