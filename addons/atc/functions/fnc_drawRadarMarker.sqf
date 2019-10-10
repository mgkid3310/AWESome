#include "script_component.hpp"

params ["_vehicle", "_callsign", "_mode", "_markerColor"];

private _speed = 3.6 * vectorMagnitude velocity _vehicle;
private _altitude = getPosASL _vehicle select 2;

if (GVAR(unitSettingAlt)) then {
	_altitude = round (_altitude * EGVAR(main,mToFt) / 100);
} else {
	_altitude = round (_altitude / 10);
};

private _verticalSpd = velocity _vehicle select 2;
private _verticalTrend = "";
switch (true) do {
	case (_verticalSpd > GVAR(minVerticalSpd)): {_verticalTrend = toString [8593];};
	case (_verticalSpd < -GVAR(minVerticalSpd)): {_verticalTrend = toString [8595];};
};

private _speedDisplay = round ([_speed, _speed * EGVAR(main,kphToKnot)] select GVAR(unitSettingSpd));
private _heading = round direction _vehicle;

private _line1 = format ["%1", _callsign];
private _line2 = "";
private _line3 = "";
private _line4 = "";

if (_mode in [2, 3]) then {
	_line2 = format ["%1%2     %3", _altitude, _verticalTrend, _speedDisplay];
	_line3 = format ["%1", _heading];

	switch (count str _altitude) do {
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

private _markerIndex = missionNameSpace getVariable [QGVAR(markerIndex), 0];
missionNameSpace setVariable [QGVAR(markerIndex), _markerIndex + 1];

private _marker0 = createMarkerLocal [format ["orbis_atc_%1_0", _markerIndex], getPos _vehicle];
_marker0 setMarkerTypeLocal _type;
_marker0 setMarkerColorLocal _markerColor;
_marker0 setMarkerTextLocal "";

private _marker1 = createMarkerLocal [format ["orbis_atc_%1_1", _markerIndex], getPos _vehicle];
_marker1 setMarkerTypeLocal _type;
_marker1 setMarkerColorLocal _markerColor;
_marker1 setMarkerSizeLocal [0, 0];
_marker1 setMarkerTextLocal _line1;

private _marker2 = createMarkerLocal [format ["orbis_atc_%1_2", _markerIndex], getPos _vehicle];
_marker2 setMarkerTypeLocal _type;
_marker2 setMarkerColorLocal _markerColor;
_marker2 setMarkerSizeLocal [0, 0];
_marker2 setMarkerTextLocal _line2;

private _marker3 = createMarkerLocal [format ["orbis_atc_%1_3", _markerIndex], getPos _vehicle];
_marker3 setMarkerTypeLocal _type;
_marker3 setMarkerColorLocal _markerColor;
_marker3 setMarkerSizeLocal [0, 0];
_marker3 setMarkerTextLocal _line3;

private _marker4 = createMarkerLocal [format ["orbis_atc_%1_4", _markerIndex], getPos _vehicle];
_marker4 setMarkerTypeLocal _type;
_marker4 setMarkerColorLocal "ColorRed";
_marker4 setMarkerSizeLocal [0, 0];
_marker4 setMarkerTextLocal _line4;

private _return = [_marker0, _marker1, _marker2, _marker3, _marker4, getPos _vehicle];

_return
