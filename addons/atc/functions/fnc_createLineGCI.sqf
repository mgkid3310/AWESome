#include "script_component.hpp"

params ["_blues", "_reds"];

private "_blue";
private _lines = [];
{
	_blue = _x;
	{
		_lines pushBack ([_blue, _x] call FUNC(drawLineGCI));
	} forEach _reds;
} forEach _blues;

_lines
