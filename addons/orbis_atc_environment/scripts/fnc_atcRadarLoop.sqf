private _monitor = _this select 0;
private _controller = param [1, player];

private _planes = [];
private _helies = [];
private _loadData = _monitor getVariable ["orbis_atc_radar_data", [0, [], [], [], []]];
_loadData params ["_timeNext", "_trailsOld", "_planeMarkers", "_heliMarkers", "_trailMarkers"];

if (((_controller distance _monitor) > 10) || (_controller getVariable ["orbis_atc_exitRadar", false])) exitWith {
	[_monitor, _controller, _planeMarkers + _heliMarkers, _trailMarkers] call orbis_atc_fnc_atcRadarExit;
};

// update planes info
if (time > _timeNext) then {
	private ["_planesAuto", "_heliesAuto", "_planesModeC", "_heliesModeC", "_planesStandBy", "_heliesStandBy",
	"_planeMarkersModeC", "_heliMarkersModeC", "_planeMarkersStandBy", "_heliMarkersStandBy"];

	_planes = (entities "Plane") select {(side driver _x in [side _controller, civilian]) && (alive _x)};
	_helies = (entities "Helicopter") select {(side driver _x in [side _controller, civilian]) && (alive _x)};
	_planesAuto = [_planes] call orbis_atc_fnc_getAutoTransponders;
	_heliesAuto = [_helies] call orbis_atc_fnc_getAutoTransponders;

	_planesModeC = (_planes - _planesAuto) select {_x getVariable ["orbis_gpws_transponderMode", 0] isEqualTo 2};
	_heliesModeC = (_helies - _heliesAuto) select {_x getVariable ["orbis_gpws_transponderMode", 0] isEqualTo 2};
	_planesStandBy = (_planes - _planesAuto) select {_x getVariable ["orbis_gpws_transponderMode", 0] isEqualTo 1};
	_heliesStandBy = (_helies - _heliesAuto) select {_x getVariable ["orbis_gpws_transponderMode", 0] isEqualTo 1};

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

	_planeMarkersModeC = [_planesModeC, "b_plane", 2] call orbis_atc_fnc_createMarkers;
	_heliMarkersModeC = [_heliesModeC, "b_air", 2] call orbis_atc_fnc_createMarkers;
	_planeMarkersStandBy = [_planesStandBy, "b_plane", 1] call orbis_atc_fnc_createMarkers;
	_heliMarkersStandBy = [_heliesStandBy, "b_air", 1] call orbis_atc_fnc_createMarkers;
	_trailMarkers = [_trailsOld, _planesModeC + _heliesModeC] call orbis_atc_fnc_createTrails;

	_planeMarkers = _planeMarkersModeC + _planeMarkersStandBy;
	_heliMarkers = _heliMarkersModeC + _heliMarkersStandBy;
	[_planeMarkers, _heliMarkers] call orbis_atc_fnc_updateMarkerSpacing;
	missionNamespace setVariable ["oribs_atc_planeMarkers", _planeMarkers];
	missionNamespace setVariable ["oribs_atc_heliMarkers", _heliMarkers];

	private _trails = [];
	{
		_trails pushBack (_x select {(alive (_x select 0)) && (isEngineOn (_x select 0)) && ((_x select 0)in (_planesModeC + _heliesModeC))});
	} forEach _trailsOld;

	_trails pushBack ((_planes apply {[_x, getPos _x]}) + (_helies apply {[_x, getPos _x]}));
	while {count _trails > orbis_atc_radarTrailLength} do {
		_trails deleteAt 0;
	};

	_timeNext = time + orbis_atc_radarUpdateInterval;
	_monitor setVariable ["orbis_atc_radar_data", [_timeNext, _trails, _planeMarkers, _heliMarkers, _trailMarkers]];
};

// ACE_map capability
if (orbis_awesome_hasACEMap) then {
	{
		_x setVariable ["ace_map_hideBlueForceMarker", (vehicle _x) in (_planes + _helies)];
	} forEach allPlayers;
};

// update marker line spacing
[_planeMarkers + _heliMarkers] call orbis_atc_fnc_updateMarkerSpacing;
