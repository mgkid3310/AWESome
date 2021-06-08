params [_list, [_indexes, []]];

if (count _list > count _indexes) then {
	private _products = [];

	for "_i" from 0 to (count _list - 1) do {
		_products append ([_list, _indexes + [_i]] call FUNC(combinatnionProduct));
	};

	_products
} else {
	private _product = [];
	{
		_product pushBack (_list select _forEachIndex select _x);
	} forEach _indexes;

	[_product]
};
