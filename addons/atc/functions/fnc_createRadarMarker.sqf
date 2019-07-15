#include "script_component.hpp"

params ["_array", "_type", ["_mode", 2]];

private ["_speed", "_altitude", "_callsign", "_altitudeDisplay", "_verticalSpd", "_verticalTrend", "_speedDisplay", "_heading",
	"_line1", "_line2", "_line3", "_line4", "_marker0", "_marker1", "_marker2", "_marker3", "_marker4"
];
private _return = [];
{
	_speed = 3.6 * vectorMagnitude velocity _x;
	_altitude = getPosASL _x select 2;

	switch (GVAR(displayCallsign)) do {
		case (1): {
			_callsign = groupId group driver _x;
		};
		case (2): {
			_callsign = _x getVariable [QGVAR(customCallsign), groupId group driver _x];
		};
		default {
			_callsign = name driver _x;
		};
	};

	if (GVAR(unitSettingAlt)) then {
		_altitudeDisplay = round (_altitude * EGVAR(main,mToFt) / 100);
	} else {
		_altitudeDisplay = round (_altitude / 10);
	};

	_verticalSpd = velocity _x select 2;
	_verticalTrend = "";
	switch (true) do {
		case (_verticalSpd > GVAR(minVerticalSpd)): {_verticalTrend = toString [8593];};
		case (_verticalSpd < -GVAR(minVerticalSpd)): {_verticalTrend = toString [8595];};
	};

	_speedDisplay = round ([_speed, _speed * EGVAR(main,kphToKnot)] select GVAR(unitSettingSpd));
	_heading = round direction _x;

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

	_marker0 = createMarkerLocal [format ["orbis_atc_%1_%2_%3_0", _type, _mode, _forEachIndex], getPos _x];
	_marker0 setMarkerTypeLocal _type;
	_marker0 setMarkerColorLocal "colorBLUFOR";
	_marker0 setMarkerTextLocal "";

	_marker1 = createMarkerLocal [format ["orbis_atc_%1_%2_%3_1", _type, _mode, _forEachIndex], getPos _x];
	_marker1 setMarkerTypeLocal _type;
	_marker1 setMarkerColorLocal "colorBLUFOR";
	_marker1 setMarkerSizeLocal [0, 0];
	_marker1 setMarkerTextLocal _line1;

	_marker2 = createMarkerLocal [format ["orbis_atc_%1_%2_%3_2", _type, _mode, _forEachIndex], getPos _x];
	_marker2 setMarkerTypeLocal _type;
	_marker2 setMarkerColorLocal "colorBLUFOR";
	_marker2 setMarkerSizeLocal [0, 0];
	_marker2 setMarkerTextLocal _line2;

	_marker3 = createMarkerLocal [format ["orbis_atc_%1_%2_%3_3", _type, _mode, _forEachIndex], getPos _x];
	_marker3 setMarkerTypeLocal _type;
	_marker3 setMarkerColorLocal "colorBLUFOR";
	_marker3 setMarkerSizeLocal [0, 0];
	_marker3 setMarkerTextLocal _line3;

	_marker4 = createMarkerLocal [format ["orbis_atc_%1_%2_%3_4", _type, _mode, _forEachIndex], getPos _x];
	_marker4 setMarkerTypeLocal _type;
	_marker4 setMarkerColorLocal "ColorRed";
	_marker4 setMarkerSizeLocal [0, 0];
	_marker4 setMarkerTextLocal _line4;

	_return pushback [_marker0, _marker1, _marker2, _marker3, _marker4, getPos _x];
} forEach _array;

[_return] call FUNC(updateMarkerSpacing);

_return
