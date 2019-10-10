#include "script_component.hpp"

params ["_trailLog", "_vehicles", ["_radarSide", civilian], ["_colorMode", 0]];

private ["_target", "_targetTrail", "_pos1", "_pos2", "_time1", "_time2", "_posMarker", "_marker", "_side", "_markerColor"];
private _return = [];
{
	_target = _x;

	_targetTrail = _trailLog select {_x select 0 isEqualTo _target};
	if (count _targetTrail > 0) then {
		for "_trailNum" from 1 to GVAR(radarTrailLength) do {
			_posMarker = [];

			for "_index" from (count _targetTrail - 1) to 0 step -1 do {
				if ((_targetTrail select _index select 2) + _trailNum <= time) exitWith {
					if (_index isEqualTo (count _targetTrail - 1)) then {
						_posMarker = _targetTrail select _index select 1;
					} else {
						_pos1 = _targetTrail select _index select 1;
						_pos2 = _targetTrail select (_index + 1) select 1;
						_time1 = _targetTrail select _index select 2;
						_time2 = _targetTrail select (_index + 1) select 2;
						_posMarker = _pos1 vectorAdd ((_pos2 vectorDiff _pos1) vectorMultiply ((time - _trailNum - _time1) / (_time2 - _time1)));
					};
				};
			};

			if !(count _posMarker > 0) exitWith {};

			_side = side driver _x;
			_markerColor = [_side, _radarSide, _colorMode] call FUNC(getRadarMarkerColor);

			private _markerIndex = missionNameSpace getVariable [QGVAR(markerIndex), 0];
			missionNameSpace setVariable [QGVAR(markerIndex), _markerIndex + 1];

			_marker = createMarkerLocal [format ["orbis_atc_%1_trail", _markerIndex], _posMarker];
			_marker setMarkerTypeLocal "hd_dot_noShadow";
			_marker setMarkerColorLocal _markerColor;
			_marker setMarkerTextLocal "";
			_return pushBack _marker;
		};
	};
} forEach _vehicles;

_return
