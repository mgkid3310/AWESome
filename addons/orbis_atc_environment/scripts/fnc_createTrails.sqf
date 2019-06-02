params ["_array", "_filter"];

private ["_timeIndex", "_marker"];
private _return = [];
{
	_timeIndex = _forEachIndex;
	{
		_x params ["_vehicle", "_position"];

		if ((alive _vehicle) && (isEngineOn _vehicle) && (_vehicle in _filter)) then {
			_marker = createMarkerLocal [format ["orbis_atc_trail_%1_%2", _timeIndex, _forEachIndex], _position];
			_marker setMarkerTypeLocal "hd_dot_noShadow";
			_marker setMarkerColorLocal "colorBLUFOR";
			_marker setMarkerTextLocal "";
		};

		_return pushBack _marker;
	} forEach _x;
} forEach _array;

_return
