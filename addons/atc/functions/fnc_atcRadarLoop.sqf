#include "script_component.hpp"

private _monitor = _this select 0;
private _controller = param [1, player];

private _loadData = _monitor getVariable [QGVAR(radarData), [0, 0, [], [], [], []]];
_loadData params ["_timeOld", "_radarTime", "_trailLog", "_planeMarkers", "_heliMarkers", "_weaponMarkers", "_trailMarkers"];

if (((_controller distance _monitor) > 10) || (_controller getVariable [QGVAR(exitRadar), false])) exitWith {
	[_monitor, _controller, _planeMarkers + _heliMarkers + _weaponMarkers, _trailMarkers] call FUNC(atcRadarExit);
};

if !(time > _timeOld) exitWith {};

private ["_planes", "_helies"];
private _isObserver = _controller getVariable [QGVAR(isObserver), false];
if (_isObserver) then {
	_planes = (entities "Plane") select {alive _x};
	_helies = (entities "Helicopter") select {alive _x};
} else {
	_planes = (entities "Plane") select {(side driver _x in [side _controller, civilian]) && (alive _x)};
	_helies = (entities "Helicopter") select {(side driver _x in [side _controller, civilian]) && (alive _x)};
};

{
	_x setVariable [QGVAR(eventWeaponFire), _x addEventHandler ["Fired", {_this spawn FUNC(eventWeaponFire)}]];
} forEach ((_plane + _helies) select {_x getVariable [QGVAR(eventWeaponFire), -1] < 0});

// update planes info
if (time > _radarTime + GVAR(radarUpdateInterval)) then {
	private _planesAuto = [_planes] call FUNC(getAutoTransponders);
	private _heliesAuto = [_helies] call FUNC(getAutoTransponders);
	private _planesManual = _planes - _planesAuto;
	private _heliesManual = _helies - _heliesAuto;

	private _planesModeC = _planesManual select {_x getVariable [QEGVAR(gpws,transponderMode), 0] isEqualTo 2};
	private _heliesModeC = _heliesManual select {_x getVariable [QEGVAR(gpws,transponderMode), 0] isEqualTo 2};
	private _planesStandBy = _planesManual select {_x getVariable [QEGVAR(gpws,transponderMode), 0] isEqualTo 1};
	private _heliesStandBy = _heliesManual select {_x getVariable [QEGVAR(gpws,transponderMode), 0] isEqualTo 1};

	_planesModeC = _planesModeC + (_planesAuto select {(isEngineOn _x) && (!isTouchingGround _x)});
	_heliesModeC = _heliesModeC + (_heliesAuto select {(isEngineOn _x) && (!isTouchingGround _x)});
	_planesStandBy = _planesStandBy + (_planesAuto select {(isEngineOn _x) && (isTouchingGround _x)});
	_heliesStandBy = _heliesStandBy + (_heliesAuto select {(isEngineOn _x) && (isTouchingGround _x)});

	private _trackedWeapons = missionNamespace getVariable [QGVAR(trackedWeapons), []];
	if !(_isObserver) then {
		_trackedWeapons = _trackedWeapons select {_x select 2 isEqualTo side _controller};
	};

	private _weaponObjects = _trackedWeapons apply {_x select 0};
	if !(GVAR(displayProjectileTrails)) then {
		_weaponObjects = [];
	};

	private ["_targetObject", "_vehicleTrail", "_targetTrail"];
	private _trailLogOld = _trailLog;
	_trailLog = [];
	{
		_targetObject = _x;
		_vehicleTrail = _trailLogOld select {_x select 0 isEqualTo _targetObject};
		_targetTrail = _vehicleTrail select {(_x select 2) + GVAR(radarTrailLength) >= time};

		if (_vehicleTrail find (_targetTrail select 0) > 0) then {
			_trailLog pushBack (_vehicleTrail select ((_vehicleTrail find (_targetTrail select 0)) - 1));
		};
		_trailLog append _targetTrail;
		_trailLog pushBack [_x, getPos _x, time];

		_trailLogOld = _trailLogOld - _vehicleTrail;
	} forEach (_planesModeC + _heliesModeC + _weaponObjects);

	{
		_x params ["_marker0", "_marker1", "_marker2", "_marker3", "_marker4"];
		deleteMarkerLocal _marker0;
		deleteMarkerLocal _marker1;
		deleteMarkerLocal _marker2;
		deleteMarkerLocal _marker3;
		deleteMarkerLocal _marker4;
	} forEach (_planeMarkers + _heliMarkers + _weaponMarkers);

	{
		deleteMarkerLocal _x;
	} forEach _trailMarkers;

	_trailMarkers = [_trailLog, _planesModeC + _heliesModeC, _weaponObjects, _isObserver] call FUNC(createRadarTrails);
	private _planeMarkersModeC = [_planesModeC, "b_plane", 2, _isObserver] call FUNC(createRadarMarker);
	private _heliMarkersModeC = [_heliesModeC, "b_air", 2, _isObserver] call FUNC(createRadarMarker);
	private _planeMarkersStandBy = [_planesStandBy, "b_plane", 1, _isObserver] call FUNC(createRadarMarker);
	private _heliMarkersStandBy = [_heliesStandBy, "b_air", 1, _isObserver] call FUNC(createRadarMarker);
	_weaponMarkers = [_trackedWeapons, "b_plane", 3, _isObserver] call FUNC(createRadarMarker);

	_planeMarkers = _planeMarkersModeC + _planeMarkersStandBy;
	_heliMarkers = _heliMarkersModeC + _heliMarkersStandBy;
	[_planeMarkers + _heliMarkers + _weaponMarkers] call FUNC(updateMarkerSpacing);

	_radarTime = time;
};

_monitor setVariable [QGVAR(radarData), [time, _radarTime, _trailLog, _planeMarkers, _heliMarkers, _weaponMarkers, _trailMarkers]];

// ACE_map capability
if (EGVAR(main,hasACEMap)) then {
	{
		_x setVariable ["ace_map_hideBlueForceMarker", (vehicle _x) in (_planes + _helies)];
	} forEach allPlayers;
};

// update marker line spacing
[_planeMarkers + _heliMarkers] call FUNC(updateMarkerSpacing);
