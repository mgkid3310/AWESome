#include "script_component.hpp"

params [["_circles", []]];

private _newLIst = [];
{
	if ((_x select 2) getVariable [QGVAR(selectedGCI), false]) then {
		_newLIst pushBack _x;
	} else {
		deleteMarkerLocal (_x select 0 select 0);
	};
} forEach _circles;

_newLIst
