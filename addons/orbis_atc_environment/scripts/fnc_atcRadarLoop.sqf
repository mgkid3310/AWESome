private _monitor = _this select 0;
private _controller = param [1, player];

private ["_planes", "_helies", "_trails", "_crewList"];
private _loadData = _monitor getVariable ["orbis_atc_radar_data", [0, [], [], [], []]];
_loadData params ["_timeNext", "_trailsOld", "_planeMarkers", "_heliMarkers", "_trailMarkers"];

if (((_controller distance _monitor) > 10) || !(player getVariable ["orbis_atc_isUsingRadarScreen", true])) exitWith {
	[_monitor, _controller, _planeMarkers + _heliMarkers, _trailMarkers] call orbis_atc_fnc_atcRadarExit;
};

// update planes info
if (time > _timeNext) then {
	_planes = (entities "Plane") select {(side driver _x in [side _controller, civilian]) && (alive _x) && (isEngineOn _x)};
	_helies = (entities "Helicopter") select {(side driver _x in [side _controller, civilian]) && (alive _x) && (isEngineOn _x)};

	{
		_x params ["_marker0", "_marker1", "_marker2", "_marker3"];
		deleteMarkerLocal _marker0;
		deleteMarkerLocal _marker1;
		deleteMarkerLocal _marker2;
		deleteMarkerLocal _marker3;
	} forEach (_planeMarkers + _heliMarkers);

	{
		deleteMarkerLocal _x;
	} forEach _trailMarkers;

	_planeMarkers = [_planes, "b_plane"] call orbis_atc_fnc_createMarkers;
	_heliMarkers = [_helies, "b_air"] call orbis_atc_fnc_createMarkers;
	_trailMarkers = [_trailsOld] call orbis_atc_fnc_createTrails;
	[_planeMarkers, _heliMarkers] call orbis_atc_fnc_updateMarkerSpacing;
	missionNamespace setVariable ["oribs_atc_planeMarkers", _planeMarkers];
	missionNamespace setVariable ["oribs_atc_heliMarkers", _heliMarkers];

	_trails = [];
	{
		_trails pushBack (_x select {(alive (_x select 0)) && (isEngineOn (_x select 0))});
	} forEach _trailsOld;

	_trails pushBack ((_planes apply {[_x, getPos _x]}) + (_helies apply {[_x, getPos _x]}));
	while {count _trails > orbis_atc_radarTrailLength} do {
		_trails deleteAt 0;
	};

	_timeNext = time + orbis_atc_radarUpdateInterval;
};

// ACE_map capability
if (orbis_awesome_hasACEMap) then {
	{
		_x setVariable ["ace_map_hideBlueForceMarker", (vehicle _x) in (_planes + _helies)];
	} forEach allPlayers;
};

// update marker line spacing
[_planeMarkers + _heliMarkers] call orbis_atc_fnc_updateMarkerSpacing;

_monitor setVariable ["orbis_atc_radar_data", [_timeNext, _trails, _planeMarkers, _heliMarkers, _trailMarkers]];
