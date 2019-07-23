#include "script_component.hpp"

params ["_trailLog", "_vehicles", ["_projectiles", []], ["_radarSide", civilian], ["_isObserver", false]];

private ["_target", "_targetTrail", "_pos1", "_pos2", "_time1", "_time2", "_posMarker", "_marker", "_side", "_markerColor"];
private _return = [];
{
	if (_x isEqualType []) then {
		_target = _x select 0;
	} else {
		_target = _x;
	};

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

			if (_x isEqualType []) then {
				_side = _x select 2;
			} else {
				_side = side driver _x;
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

			_marker = createMarkerLocal [format ["orbis_atc_trail_%1_%2", _target, _trailNum], _posMarker];
			_marker setMarkerTypeLocal "hd_dot_noShadow";
			_marker setMarkerColorLocal _markerColor;
			_marker setMarkerTextLocal "";
			_return pushBack _marker;
		};
	};
} forEach (_vehicles + _projectiles);

_return
