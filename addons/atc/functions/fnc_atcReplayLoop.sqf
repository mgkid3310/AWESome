#include "script_component.hpp"

private _monitor = _this select 0;
private _controller = param [1, player];
private _replay = param [2, -1];

private _loadData = _monitor getVariable [QGVAR(replayData), [0, 0, [], [], [], []]];
_loadData params ["_timeOld", "_radarTime", "_trailLogOld", "_planeMarkers", "_heliMarkers", "_weaponMarkers", "_trailMarkers"];

if (((_controller distance _monitor) > 10) || (_controller getVariable [QGVAR(exitReplay), false])) exitWith {
	[_monitor, _controller, _planeMarkers + _heliMarkers + _weaponMarkers, _trailMarkers] call FUNC(atcReplayExit);
};

private _isReplay = !(_replay < 0);
if (_isReplay && (_replay < count (missionNamespace getVariable [QGVAR(radarReplayData), []]))) exitWith {};

private ["_time", "_replayData", "_replayTime"];
_replayData = (missionNamespace getVariable [QGVAR(radarReplayData), []) select _replay;
_replayTime = missionNamespace getVariable [QGVAR(radarReplayTime), false];
if !(_replayTime isEqualType 0) then {
	_replayTime = time;
	missionNamespace setVariable [QGVAR(radarReplayTime), time];
};
_time = time - _replayTime + (_replayData select 0) + (missionNamespace getVariable [QGVAR(radarReplaySkip), 0]);

if !(_time > _timeOld) exitWith {};

private _index = -1;
for "_i" from 0 to (count _replayData - 1) do {
	if (_time < _replayData select _i select 0) exitWith {};
	_index = _i;
};

if (_index < 0) exitWith {
	_controller setVariable [QGVAR(exitReplay), true];
};

private _currentReplay = _replayData select _index;

private _planesModeC = _currentReplay select {_x select 1 isEqualTo 0};
private _heliesModeC = _currentReplay select {_x select 1 isEqualTo 1};
private _planesStandBy = _currentReplay select {_x select 1 isEqualTo 2};
private _heliesStandBy = _currentReplay select {_x select 1 isEqualTo 3};
private _trackedWeapons = _currentReplay select {_x select 1 isEqualTo 4};

private _weaponObjects = _trackedWeapons apply {_x select 0};
if !(GVAR(displayProjectileTrails)) then {
	_weaponObjects = [];
};

private ["_targetObject", "_vehicleTrail", "_targetTrail"];
private _trailLog = [];
{
	_targetObject = _x;
	_vehicleTrail = _trailLogOld select {_x select 0 isEqualTo _targetObject};
	_targetTrail = _vehicleTrail select {(_x select 2) + GVAR(radarTrailLength) >= _time};

	if (_vehicleTrail find (_targetTrail select 0) > 0) then {
		_trailLog pushBack (_vehicleTrail select ((_vehicleTrail find (_targetTrail select 0)) - 1));
	};
	_trailLog append _targetTrail;
	_trailLog pushBack [_x, getPos _x, _time];

	_trailLogOld = _trailLogOld - _vehicleTrail;
} forEach (_planesModeC + _heliesModeC + _weaponObjects);

// update planes info
if (_time > _radarTime + GVAR(radarUpdateInterval)) then {
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

	_trailMarkers = [_trailLog, _planesModeC + _heliesModeC, _weaponObjects] call FUNC(createReplayTrails);
	private _planeMarkersModeC = [_planesModeC, "b_plane", 2, _isReplay] call FUNC(createReplayMarker);
	private _heliMarkersModeC = [_heliesModeC, "b_air", 2, _isReplay] call FUNC(createReplayMarker);
	private _planeMarkersStandBy = [_planesStandBy, "b_plane", 1, _isReplay] call FUNC(createReplayMarker);
	private _heliMarkersStandBy = [_heliesStandBy, "b_air", 1, _isReplay] call FUNC(createReplayMarker);
	_weaponMarkers = [_trackedWeapons, "b_plane", 3, _isObserver] call FUNC(createRadarMarker);

	_planeMarkers = _planeMarkersModeC + _planeMarkersStandBy;
	_heliMarkers = _heliMarkersModeC + _heliMarkersStandBy;
	[_planeMarkers + _heliMarkers + _weaponMarkers] call FUNC(updateMarkerSpacing);

	_radarTime = _time;
};

_monitor setVariable [QGVAR(replayData), [_time, _radarTime, _trailLog, _planeMarkers, _heliMarkers, _weaponMarkers, _trailMarkers]];

// ACE_map capability
if (EGVAR(main,hasACEMap)) then {
	{
		_x setVariable ["ace_map_hideBlueForceMarker", (vehicle _x) in (_planes + _helies)];
	} forEach allPlayers;
};

// update marker line spacing
[_planeMarkers + _heliMarkers] call FUNC(updateMarkerSpacing);
