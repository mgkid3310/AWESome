#include "script_component.hpp"

params ["_array", "_type", ["_mode", 2], ["_radarSide", civilian], ["_radarMode", 0]];

private ["_vehicle", "_callsign", "_side", "_markerColor", "_markerArray"];
private _return = [];
{
	_vehicle = _x;

	if (_radarMode isEqualTo 1) then {
		_callsign = "Bogie";
	} else {
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

	_side = side driver _vehicle;
	_markerColor = [_side, _radarSide, _radarMode] call FUNC(getRadarMarkerColor);

	_markerArray = [_vehicle, _callsign, _mode, _markerColor] call FUNC(drawRadarMarker);
	_return pushback _markerArray;
} forEach _array;

_return
