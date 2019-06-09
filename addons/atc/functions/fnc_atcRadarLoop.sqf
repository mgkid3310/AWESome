#include "script_component.hpp"

private _monitor = _this select 0;
private _controller = param [1, player];

private _planes = [];
private _helies = [];
private _loadData = _monitor getVariable [QGVAR(radarData), [0, [], [], [], []]];
_loadData params ["_timeNext", "_trailsOld", "_planeMarkers", "_heliMarkers", "_trailMarkers"];

if (((_controller distance _monitor) > 10) || (_controller getVariable [QGVAR(exitRadar), false])) exitWith {
	[_monitor, _controller, _planeMarkers + _heliMarkers, _trailMarkers] call FUNC(atcRadarExit);
};

// update planes info
if (time > _timeNext) then {
	private ["_planesAuto", "_heliesAuto", "_planesModeC", "_heliesModeC", "_planesStandBy", "_heliesStandBy",
	"_planeMarkersModeC", "_heliMarkersModeC", "_planeMarkersStandBy", "_heliMarkersStandBy"];

	_planes = (entities "Plane") select {(side driver _x in [side _controller, civilian]) && (alive _x)};
	_helies = (entities "Helicopter") select {(side driver _x in [side _controller, civilian]) && (alive _x)};
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

	_planeMarkersModeC = [_planesModeC, "b_plane", 2] call FUNC(createMarkers);
	_heliMarkersModeC = [_heliesModeC, "b_air", 2] call FUNC(createMarkers);
	_planeMarkersStandBy = [_planesStandBy, "b_plane", 1] call FUNC(createMarkers);
	_heliMarkersStandBy = [_heliesStandBy, "b_air", 1] call FUNC(createMarkers);
	_trailMarkers = [_trailsOld, _planesModeC + _heliesModeC] call FUNC(createTrails);

	_planeMarkers = _planeMarkersModeC + _planeMarkersStandBy;
	_heliMarkers = _heliMarkersModeC + _heliMarkersStandBy;
	[_planeMarkers, _heliMarkers] call FUNC(updateMarkerSpacing);

	private _trails = [];
	{
		_trails pushBack (_x select {(alive (_x select 0)) && (isEngineOn (_x select 0)) && ((_x select 0)in (_planesModeC + _heliesModeC))});
	} forEach _trailsOld;

	_trails pushBack ((_planes apply {[_x, getPos _x]}) + (_helies apply {[_x, getPos _x]}));
	while {count _trails > GVAR(radarTrailLength)} do {
		_trails deleteAt 0;
	};

	_timeNext = time + GVAR(radarUpdateInterval);
	_monitor setVariable [QGVAR(radarData), [_timeNext, _trails, _planeMarkers, _heliMarkers, _trailMarkers]];
};

// ACE_map capability
if (EGVAR(main,hasACEMap)) then {
	{
		_x setVariable ["ace_map_hideBlueForceMarker", (vehicle _x) in (_planes + _helies)];
	} forEach allPlayers;
};

// update marker line spacing
[_planeMarkers + _heliMarkers] call FUNC(updateMarkerSpacing);
