#include "script_component.hpp"

params ["_array", "_type", ["_displayDetails", true], ["_radarSide", civilian], ["_colorMode", 0]];

private ["_vehicle", "_callsign", "_side", "_markerColor", "_markerArray"];
private _return = [];
{
	_vehicle = _x;

	switch (_colorMode) do {
		case (1): {
			_callsign = format ["Bogie #%1", _vehicle getVariable [QGVAR(bogieNumber), 0]];
		};
		case (2): {
			_callsign = format ["Bandit #%1", _vehicle getVariable [QGVAR(bogieNumber), 0]];
		};
		default {
			switch (GVAR(displayCallsign)) do {
				case (1): {
					_callsign = groupId group driver _vehicle;
				};
				case (2): {
					_callsign = _vehicle getVariable [QGVAR(customCallsign), groupId group driver _vehicle];
				};
				default {
					_callsign = name driver _vehicle;
				};
			};
		};
	};

	_side = side driver _vehicle;
	_markerColor = [_side, _radarSide, _colorMode] call FUNC(getRadarMarkerColor);

	_markerArray = [_vehicle, _callsign, _displayDetails, _markerColor] call FUNC(drawRadarMarker);
	_return pushback _markerArray;
} forEach _array;

_return
