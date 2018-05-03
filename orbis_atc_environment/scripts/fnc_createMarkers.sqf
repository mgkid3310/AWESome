params ["_array", "_type"];

private _return = [];
{
    private _callsign = name (driver _x);
    private _speed = round speed _x;
    private _altitude = round (getPosASL _x select 2);
    private _heading = round direction _x;

    private _line1 = format ["%1", _callsign];
    private _line2 = format ["%1 %2", _speed, _altitude];
    private _line3 = format ["%1", _heading];

    switch (count _line3) do {
        case 0: {_line3 = "000";};
        case 1: {_line3 = "00" + _line3;};
        case 2: {_line3 = "0" + _line3;};
    };

    private _marker1 = createMarkerLocal [format ["orbis_atc_%1_%2_1", _type, count _return], getPos _x];
    _marker1 setMarkerTypeLocal _type;
    _marker1 setMarkerTextLocal _line1;

    private _marker2 = createMarkerLocal [format ["orbis_atc_%1_%2_2", _type, count _return], getPos _x];
    _marker2 setMarkerTypeLocal _type;
    _marker2 setMarkerSizeLocal [0, 0];
    _marker2 setMarkerTextLocal _line2;

    private _marker3 = createMarkerLocal [format ["orbis_atc_%1_%2_3", _type, count _return], getPos _x];
    _marker3 setMarkerTypeLocal _type;
    _marker3 setMarkerSizeLocal [0, 0];
    _marker3 setMarkerTextLocal _line3;

    _return pushback [_marker1, _marker2, _marker3, getPos _x];
} forEach _array;

[_return] call orbis_atc_fnc_updateMarkerSpacing;

_return
