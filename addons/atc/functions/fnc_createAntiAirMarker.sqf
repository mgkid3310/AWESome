#include "script_component.hpp"

params ["_array", "_type", ["_mode", 2], ["_radarSide", civilian], ["_radarMode", 0]];

private ["_vehicle", "_callsign", "_side", "_markerColor", "_markerArray"];
private _return = [];
{
	_vehicle = _x;

	_callsign = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");

	_side = side driver _vehicle;
	_markerColor = [_side, _radarSide, _radarMode] call FUNC(getRadarMarkerColor);

	_markerArray = [_vehicle, _callsign, _mode, _markerColor] call FUNC(drawRadarMarker);
	_return pushback _markerArray;
} forEach _array;

_return