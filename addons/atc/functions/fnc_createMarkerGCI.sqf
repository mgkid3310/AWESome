#include "script_component.hpp"

params ["_vehicles", "_color"];

private _markers = [];
{
	_markers pushBack ([getPos _x, _x, _color] call FUNC(drawMarkerGCI));
} forEach (_vehicles select {alive _x});

_markers
