params ["_array", "_type"];

private ["_callsign", "_speed", "_altitude", "_heading", "_line1", "_line2", "_line3", "_marker0", "_marker1", "_marker2", "_marker3"];
private _useCallsign = missionNamespace getVariable ["orbis_atc_displayCallsign", false];
private _return = [];
{
    _callsign = [name driver _x, groupId driver _x] select _useCallsign;
    _speed = round speed _x;
    _altitude = round (getPosASL _x select 2);
    _heading = round direction _x;

    _line1 = format ["%1", _callsign];
    _line2 = format ["%1 %2", _speed, _altitude];
    _line3 = format ["%1", _heading];

    switch (count _line3) do {
        case 0: {_line3 = "000";};
        case 1: {_line3 = "00" + _line3;};
        case 2: {_line3 = "0" + _line3;};
    };

    _marker0 = createMarkerLocal [format ["orbis_atc_%1_%2_0", _type, _forEachIndex], getPos _x];
    _marker0 setMarkerTypeLocal _type;
    _marker0 setMarkerTextLocal "";

    _marker1 = createMarkerLocal [format ["orbis_atc_%1_%2_1", _type, _forEachIndex], getPos _x];
    _marker1 setMarkerTypeLocal _type;
    _marker1 setMarkerSizeLocal [0, 0];
    _marker1 setMarkerTextLocal _line1;

    _marker2 = createMarkerLocal [format ["orbis_atc_%1_%2_2", _type, _forEachIndex], getPos _x];
    _marker2 setMarkerTypeLocal _type;
    _marker2 setMarkerSizeLocal [0, 0];
    _marker2 setMarkerTextLocal _line2;

    _marker3 = createMarkerLocal [format ["orbis_atc_%1_%2_3", _type, _forEachIndex], getPos _x];
    _marker3 setMarkerTypeLocal _type;
    _marker3 setMarkerSizeLocal [0, 0];
    _marker3 setMarkerTextLocal _line3;

    _return pushback [_marker0, _marker1, _marker2, _marker3, getPos _x];
} forEach _array;

[_return] call orbis_atc_fnc_updateMarkerSpacing;

_return
