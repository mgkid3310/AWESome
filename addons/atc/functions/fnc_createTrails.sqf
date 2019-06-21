#include "script_component.hpp"

params ["_trailLog", "_targets"];

private ["_targetObject", "_targetTrail", "_pos1", "_pos2", "_time1", "_time2", "_posMarker", "_targetArray", "_marker"];
private _return = [];
{
	_targetObject = _x;
	_targetTrail = _trailLog select {_x select 0 isEqualTo _targetObject};
	if (count _targetTrail > 0) then {
		for "_trailNum" from 1 to GVAR(radarTrailLength) do {
			_targetArray = [];

			for "_index" from (count _targetTrail - 1) to 0 step -1 do {
				if ((_targetTrail select _index select 2) + _trailNum <= time) exitWith {
					_posMarker = _targetTrail select _index select 1;
					/* if (_index isEqualTo (count _targetTrail - 1)) then {
						_posMarker = _targetTrail select _index select 1;
					} else {
						_pos1 = _targetTrail select _index select 1;
						_pos2 = _targetTrail select (_index + 1) select 1;
						_time1 = _targetTrail select _index select 2;
						_time2 = _targetTrail select (_index + 1) select 2;
						_posMarker = _pos1 vectorAdd ((_pos2 vectorDiff _pos1) vectorMultiply ((time - _time1) / (_time2 - _time1)));
					}; */
					_targetArray = [_targetTrail select _index select 0, _posMarker];
				};
			};

			if !(count _targetArray > 0) exitWith {};

			_targetArray params ["_vehicle", "_position"];
			_marker = createMarkerLocal [format ["orbis_atc_trail_%1_%2", _vehicle, _trailNum], _position];
			_marker setMarkerTypeLocal "hd_dot_noShadow";
			_marker setMarkerColorLocal "colorBLUFOR";
			_marker setMarkerTextLocal "";
			_return pushBack _marker;
		};
	};
} forEach (_targets select {(alive _x) && (isEngineOn _x)});

_return
