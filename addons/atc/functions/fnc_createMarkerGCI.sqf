#include "script_component.hpp"

params ["_vehicles", ["_radarSide", civilian], ["_targetType", 0]];

private "_markerColor";
private _markers = [];
{
	_markerColor = [side driver _x, _radarSide, _targetType] call FUNC(getRadarMarkerColor);
	_markers pushBack ([getPos _x, _x, _markerColor] call FUNC(drawMarkerGCI));
} forEach (_vehicles select {alive _x});

_markers
