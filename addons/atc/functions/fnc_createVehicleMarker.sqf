#include "script_component.hpp"

params ["_array", "_type", ["_displayDetails", true], ["_radarSide", civilian], ["_targetType", 0]];

private ["_vehicle", "_radarDetection", "_callsign", "_side", "_markerColor", "_markerArray"];
private _return = [];
{
	if (_x isEqualType []) then {
		_vehicle = _x select 0;
		_radarDetection = _x select 1;
	} else {
		_vehicle = _x;
		_radarDetection = 0;
	};

	switch (_targetType) do {
		case (1): {
			if (_radarDetection < GVAR(minRadarDetection)) then {
				_callsign = "Bogie";
			} else {
				_callsign = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
			};
		};
		case (2): {
			if (_radarDetection < GVAR(minRadarDetection)) then {
				_callsign = "Bandit";
			} else {
				_callsign = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
			};
		};
		default {
			switch (GVAR(displayCallsign)) do {
				case (1): {
					_callsign = groupId group driver _vehicle;
				};
				case (2): {
					_callsign = _vehicle getVariable [QGVAR(vehicleCallsign), groupId group driver _vehicle];
				};
				case (3): {
					_callsign = name driver _vehicle;
				};
				default {
					_callsign = driver _vehicle getVariable [QGVAR(personalCallsign), name driver _vehicle];
					if (_callsign isEqualTo "") then {
						_callsign = name driver _vehicle;
					};
				};
			};
		};
	};

	_side = side driver _vehicle;
	_markerColor = [_side, _radarSide, _targetType] call FUNC(getRadarMarkerColor);

	_markerArray = [_vehicle, _callsign, _displayDetails, _markerColor] call FUNC(drawRadarMarker);
	_return pushback _markerArray;
} forEach _array;

_return
