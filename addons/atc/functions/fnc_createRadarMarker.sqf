#include "script_component.hpp"

params ["_array", "_type", ["_mode", 2], ["_radarSide", civilian], ["_isObserver", false]];

private ["_vehicle", "_speed", "_altitude", "_callsign", "_altitudeDisplay", "_verticalSpd", "_verticalTrend", "_speedDisplay", "_heading", "_side", "_markerColor",
	"_line1", "_line2", "_line3", "_line4", "_marker0", "_marker1", "_marker2", "_marker3", "_marker4"
];
private _return = [];
{
	if (_mode isEqualTo 3) then {
		_vehicle = _x select 0;
	} else {
		_vehicle = _x;
	};

	_speed = 3.6 * vectorMagnitude velocity _vehicle;
	_altitude = getPosASL _vehicle select 2;

	switCh (_mode) do {
		case (3): {
			_callsign = getText (configFile >> "CfgWeapons" >> (_x select 1) >> "displayName");
		};
		case (4): {
			_callsign = getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "displayName");
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

	if (_mode isEqualTo 3) then {
		_side = _x select 2;
	} else {
		_side = side driver _vehicle;
	};

	if (_isObserver) then {
		switch (_side) do {
			case (west): {
				_markerColor = "ColorWEST";
			};
			case (east): {
				_markerColor = "ColorEAST";
			};
			case (independent): {
				_markerColor = "ColorGUER";
			};
			default {
				_markerColor = "ColorCIV";
			};
		};
	} else {
		switch (true) do {
			case (_side isEqualTo _radarSide): {
				_markerColor = "ColorWEST";
			};
			case (_side isEqualTo civilian): {
				_markerColor = "ColorWEST";
			};
			default {
				_markerColor = "ColorYellow";
			};
		};
	};

	if (GVAR(unitSettingAlt)) then {
		_altitudeDisplay = round (_altitude * EGVAR(main,mToFt) / 100);
	} else {
		_altitudeDisplay = round (_altitude / 10);
	};

	_verticalSpd = velocity _vehicle select 2;
	_verticalTrend = "";
	switch (true) do {
		case (_verticalSpd > GVAR(minVerticalSpd)): {_verticalTrend = toString [8593];};
		case (_verticalSpd < -GVAR(minVerticalSpd)): {_verticalTrend = toString [8595];};
	};

	_speedDisplay = round ([_speed, _speed * EGVAR(main,kphToKnot)] select GVAR(unitSettingSpd));
	_heading = round direction _vehicle;

	_line1 = format ["%1", _callsign];
	_line2 = "";
	_line3 = "";
	_line4 = "";

	if (_mode in [2, 3]) then {
		_line2 = format ["%1%2     %3", _altitudeDisplay, _verticalTrend, _speedDisplay];
		_line3 = format ["%1", _heading];

		switch (count str _altitudeDisplay) do {
			case 0: {_line2 = "000";};
			case 1: {_line2 = "00" + _line2;};
			case 2: {_line2 = "0" + _line2;};
		};

		switch (count _line3) do {
			case 0: {_line3 = "000";};
			case 1: {_line3 = "00" + _line3;};
			case 2: {_line3 = "0" + _line3;};
		};
	};

	_marker0 = createMarkerLocal [format ["orbis_atc_%1_%2_%3_0", _type, _mode, _forEachIndex], getPos _vehicle];
	_marker0 setMarkerTypeLocal _type;
	_marker0 setMarkerColorLocal _markerColor;
	_marker0 setMarkerTextLocal "";

	_marker1 = createMarkerLocal [format ["orbis_atc_%1_%2_%3_1", _type, _mode, _forEachIndex], getPos _vehicle];
	_marker1 setMarkerTypeLocal _type;
	_marker1 setMarkerColorLocal _markerColor;
	_marker1 setMarkerSizeLocal [0, 0];
	_marker1 setMarkerTextLocal _line1;

	_marker2 = createMarkerLocal [format ["orbis_atc_%1_%2_%3_2", _type, _mode, _forEachIndex], getPos _vehicle];
	_marker2 setMarkerTypeLocal _type;
	_marker2 setMarkerColorLocal _markerColor;
	_marker2 setMarkerSizeLocal [0, 0];
	_marker2 setMarkerTextLocal _line2;

	_marker3 = createMarkerLocal [format ["orbis_atc_%1_%2_%3_3", _type, _mode, _forEachIndex], getPos _vehicle];
	_marker3 setMarkerTypeLocal _type;
	_marker3 setMarkerColorLocal _markerColor;
	_marker3 setMarkerSizeLocal [0, 0];
	_marker3 setMarkerTextLocal _line3;

	_marker4 = createMarkerLocal [format ["orbis_atc_%1_%2_%3_4", _type, _mode, _forEachIndex], getPos _vehicle];
	_marker4 setMarkerTypeLocal _type;
	_marker4 setMarkerColorLocal "ColorRed";
	_marker4 setMarkerSizeLocal [0, 0];
	_marker4 setMarkerTextLocal _line4;

	_return pushback [_marker0, _marker1, _marker2, _marker3, _marker4, getPos _vehicle];
} forEach _array;

[_return] call FUNC(updateMarkerSpacing);

_return
