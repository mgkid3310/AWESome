#include "script_component.hpp"

params ["_array", "_type", ["_mode", 2], ["_isReplay", false]];

private ["_target", "_speed", "_altitude", "_callsign", "_altitudeDisplay", "_verticalSpd", "_verticalTrend", "_speedDisplay", "_heading", "_markerPos", "_markerColor",
	"_line1", "_line2", "_line3", "_line4", "_marker0", "_marker1", "_marker2", "_marker3", "_marker4"
];
private _return = [];
{
	_speed = _x select 2;
	_altitude = _x select 3;
	_verticalSpd = _x select 4;
	_heading = _x select 5;
	_markerPos = _x select 6;
	if (_mode < 3) then {
		switch (GVAR(displayCallsign)) do {
			case (1): {
				_callsign = _x select 7 select 1;
			};
			case (2): {
				_callsign = _x select 7 select 2;
			};
			default {
				_callsign = _x select 7 select 0;
			};
		};
	} else {
		_callsign = _x select 7 select 0;
	};
	switch (_x select 8) do {
		case (west): {
			_markerColor = "colorBLUFOR";
		};
		case (east): {
			_markerColor = "colorOPFOR";
		};
		case (independent): {
			_markerColor = "colorIndependent";
		};
		default {
			_markerColor = "colorCivilian";
		};
	};

	if (GVAR(unitSettingAlt)) then {
		_altitudeDisplay = round (_altitude * EGVAR(main,mToFt) / 100);
	} else {
		_altitudeDisplay = round (_altitude / 10);
	};

	_verticalTrend = "";
	switch (true) do {
		case (_verticalSpd > GVAR(minVerticalSpd)): {_verticalTrend = toString [8593];};
		case (_verticalSpd < -GVAR(minVerticalSpd)): {_verticalTrend = toString [8595];};
	};

	_speedDisplay = round ([_speed, _speed * EGVAR(main,kphToKnot)] select GVAR(unitSettingSpd));

	_line1 = format ["%1", _callsign];
	_line2 = "";
	_line3 = "";
	_line4 = "";

	if (_mode isEqualTo 2) then {
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

	_marker0 = createMarkerLocal [format ["orbis_atc_%1_%2_%3_0", _type, _mode, _forEachIndex], _markerPos];
	_marker0 setMarkerTypeLocal _type;
	_marker0 setMarkerColorLocal _markerColor;
	_marker0 setMarkerTextLocal "";

	_marker1 = createMarkerLocal [format ["orbis_atc_%1_%2_%3_1", _type, _mode, _forEachIndex], _markerPos];
	_marker1 setMarkerTypeLocal _type;
	_marker1 setMarkerColorLocal _markerColor;
	_marker1 setMarkerSizeLocal [0, 0];
	_marker1 setMarkerTextLocal _line1;

	_marker2 = createMarkerLocal [format ["orbis_atc_%1_%2_%3_2", _type, _mode, _forEachIndex], _markerPos];
	_marker2 setMarkerTypeLocal _type;
	_marker2 setMarkerColorLocal _markerColor;
	_marker2 setMarkerSizeLocal [0, 0];
	_marker2 setMarkerTextLocal _line2;

	_marker3 = createMarkerLocal [format ["orbis_atc_%1_%2_%3_3", _type, _mode, _forEachIndex], _markerPos];
	_marker3 setMarkerTypeLocal _type;
	_marker3 setMarkerColorLocal _markerColor;
	_marker3 setMarkerSizeLocal [0, 0];
	_marker3 setMarkerTextLocal _line3;

	_marker4 = createMarkerLocal [format ["orbis_atc_%1_%2_%3_4", _type, _mode, _forEachIndex], _markerPos];
	_marker4 setMarkerTypeLocal _type;
	_marker4 setMarkerColorLocal "ColorRed";
	_marker4 setMarkerSizeLocal [0, 0];
	_marker4 setMarkerTextLocal _line4;

	_return pushback [_marker0, _marker1, _marker2, _marker3, _marker4, _markerPos];
} forEach _array;

[_return] call FUNC(updateMarkerSpacing);

_return
