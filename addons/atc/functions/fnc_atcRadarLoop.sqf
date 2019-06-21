#include "script_component.hpp"

private _monitor = _this select 0;
private _controller = param [1, player];

private _loadData = _monitor getVariable [QGVAR(radarData), [0, 0, [], [], [], []]];
_loadData params ["_timeOld", "_radarTime", "_trailLog", "_planeMarkers", "_heliMarkers", "_trailMarkers"];

if (((_controller distance _monitor) > 10) || (_controller getVariable [QGVAR(exitRadar), false])) exitWith {
	[_monitor, _controller, _planeMarkers + _heliMarkers, _trailMarkers] call FUNC(atcRadarExit);
};

if !(time > _timeOld) exitWith {};

private _planes = (entities "Plane") select {(side driver _x in [side _controller, civilian]) && (alive _x)};
private _helies = (entities "Helicopter") select {(side driver _x in [side _controller, civilian]) && (alive _x)};
private _planesAuto = [_planes] call FUNC(getAutoTransponders);
private _heliesAuto = [_helies] call FUNC(getAutoTransponders);

private _planesModeC = (_planes - _planesAuto) select {_x getVariable [QEGVAR(gpws,transponderMode), 0] isEqualTo 2};
private _heliesModeC = (_helies - _heliesAuto) select {_x getVariable [QEGVAR(gpws,transponderMode), 0] isEqualTo 2};
private _planesStandBy = (_planes - _planesAuto) select {_x getVariable [QEGVAR(gpws,transponderMode), 0] isEqualTo 1};
private _heliesStandBy = (_helies - _heliesAuto) select {_x getVariable [QEGVAR(gpws,transponderMode), 0] isEqualTo 1};

_planesModeC = _planesModeC + (_planesAuto select {!isTouchingGround _x});
_heliesModeC = _heliesModeC + (_heliesAuto select {!isTouchingGround _x});
_planesStandBy = _planesStandBy + (_planesAuto select {isTouchingGround _x});
_heliesStandBy = _heliesStandBy + (_heliesAuto select {isTouchingGround _x});

{
	_trailLog pushBack [_x, getPos _x, time];
} forEach (_planesModeC + _heliesModeC);

// update planes info
if (time > _radarTime + GVAR(radarUpdateInterval)) then {
	private ["_planeMarkersModeC", "_heliMarkersModeC", "_planeMarkersStandBy", "_heliMarkersStandBy"];

	_planesAuto = [_planes] call FUNC(getAutoTransponders);
	_heliesAuto = [_helies] call FUNC(getAutoTransponders);

	_planesModeC = (_planes - _planesAuto) select {_x getVariable [QEGVAR(gpws,transponderMode), 0] isEqualTo 2};
	_heliesModeC = (_helies - _heliesAuto) select {_x getVariable [QEGVAR(gpws,transponderMode), 0] isEqualTo 2};
	_planesStandBy = (_planes - _planesAuto) select {_x getVariable [QEGVAR(gpws,transponderMode), 0] isEqualTo 1};
	_heliesStandBy = (_helies - _heliesAuto) select {_x getVariable [QEGVAR(gpws,transponderMode), 0] isEqualTo 1};

	_planesModeC = _planesModeC + (_planesAuto select {!isTouchingGround _x});
	_heliesModeC = _heliesModeC + (_heliesAuto select {!isTouchingGround _x});
	_planesStandBy = _planesStandBy + (_planesAuto select {isTouchingGround _x});
	_heliesStandBy = _heliesStandBy + (_heliesAuto select {isTouchingGround _x});

	{
		_x params ["_marker0", "_marker1", "_marker2", "_marker3", "_marker4"];
		deleteMarkerLocal _marker0;
		deleteMarkerLocal _marker1;
		deleteMarkerLocal _marker2;
		deleteMarkerLocal _marker3;
		deleteMarkerLocal _marker4;
	} forEach (_planeMarkers + _heliMarkers);

	{
		deleteMarkerLocal _x;
	} forEach _trailMarkers;

	_trailLog = _trailLog select {(_x select 2) + GVAR(radarTrailLength) + 1 >= time};

	_planeMarkersModeC = [_planesModeC, "b_plane", 2] call FUNC(createMarkers);
	_heliMarkersModeC = [_heliesModeC, "b_air", 2] call FUNC(createMarkers);
	_planeMarkersStandBy = [_planesStandBy, "b_plane", 1] call FUNC(createMarkers);
	_heliMarkersStandBy = [_heliesStandBy, "b_air", 1] call FUNC(createMarkers);
	_trailMarkers = [_trailLog, _planesModeC + _heliesModeC] call FUNC(createTrails);

	_planeMarkers = _planeMarkersModeC + _planeMarkersStandBy;
	_heliMarkers = _heliMarkersModeC + _heliMarkersStandBy;
	[_planeMarkers, _heliMarkers] call FUNC(updateMarkerSpacing);

	_radarTime = time;
};

_monitor setVariable [QGVAR(radarData), [time, _radarTime, _trailLog, _planeMarkers, _heliMarkers, _trailMarkers]];

// ACE_map capability
if (EGVAR(main,hasACEMap)) then {
	{
		_x setVariable ["ace_map_hideBlueForceMarker", (vehicle _x) in (_planes + _helies)];
	} forEach allPlayers;
};

// update marker line spacing
[_planeMarkers + _heliMarkers] call FUNC(updateMarkerSpacing);
