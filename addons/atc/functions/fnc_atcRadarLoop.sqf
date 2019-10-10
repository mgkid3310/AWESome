#include "script_component.hpp"

params ["_monitor", ["_controller", player], ["_radarMode", 0]];

private _loadData = _monitor getVariable [QGVAR(radarData), [0, 0, [], [], [], []]];
_loadData params ["_timeOld", "_radarTime", "_trailLog", "_trailMarkers", "_vehicleMarkers", "_weaponMarkers", "_antiAirMarkers"];

if (!(alive _controller) || ((_controller distance _monitor) > 10) || (_controller getVariable [QGVAR(exitRadar), false])) exitWith {
	[_monitor, _controller, _trailMarkers, _vehicleMarkers + _weaponMarkers + _antiAirMarkers] call FUNC(atcRadarExit);
};

if !(time > _timeOld) exitWith {};

private ["_planes", "_helies"];
private _radarSide = side _controller;
private _isObserver = _controller getVariable [QGVAR(isObserver), false];
if (_isObserver) then {
	_radarMode = -1;
};

// update planes info
if (time > _radarTime + GVAR(radarUpdateInterval)) then {
	missionNameSpace setVariable [QGVAR(markerIndex), 0];

	if (_isObserver) then {
		_planes = (entities "Plane") select {alive _x};
		_helies = (entities "Helicopter") select {alive _x};
	} else {
		_planes = (entities "Plane") select {(side driver _x in [_radarSide, civilian]) && (alive _x)};
		_helies = (entities "Helicopter") select {(side driver _x in [_radarSide, civilian]) && (alive _x)};
	};

	private _planesBogie = [];
	private _heliesBogie = [];
	if (!_isObserver && (_radarMode > 0)) then {};

	private _additionalPlanes = missionNameSpace getVariable [QGVAR(additionalPlanes), []];
	private _additionalHelies = missionNameSpace getVariable [QGVAR(additionalHelies), []];
	{
		_planes pushBackUnique _x;
	} forEach _additionalPlanes;
	{
		_helies pushBackUnique _x;
	} forEach _additionalHelies;

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

	private _SAMlaunchers = [];
	if !(_isObserver) then {
		_SAMlaunchers = _SAMlaunchers select {side _x isEqualTo _radarSide};
	};

	private _additionalSAMs = missionNameSpace getVariable [QGVAR(additionalSAMs), []];
	{
		_SAMlaunchers pushBackUnique _x;
	} forEach _additionalSAMs;

	private _trackedWeapons = missionNamespace getVariable [QGVAR(trackedWeapons), []];
	if !(_isObserver) then {
		_trackedWeapons = _trackedWeapons select {(_x select 2 isEqualTo _radarSide) || (_x select 3)};
	};
	private _weaponObjects = [[], _trackedWeapons apply {_x select 0}] select GVAR(displayProjectileTrails);

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
	} forEach (_vehicleMarkers + _weaponMarkers + _antiAirMarkers);

	{
		deleteMarkerLocal _x;
	} forEach _trailMarkers;

	private _vehicleTarils = [_trailLog, _planesModeC + _heliesModeC, _weaponObjects, _radarSide, _radarMode] call FUNC(createVehicleTrails);
	private _weaponTrails = [_trailLog, _planesModeC + _heliesModeC, _weaponObjects, _radarSide, _radarMode] call FUNC(createWeaponTrails);
	private _planeMarkersModeC = [_planesModeC, "b_plane", true, _radarSide, _radarMode] call FUNC(createVehicleMarker);
	private _heliMarkersModeC = [_heliesModeC, "b_air", true, _radarSide, _radarMode] call FUNC(createVehicleMarker);
	private _planeMarkersStandBy = [_planesStandBy, "b_plane", false, _radarSide, _radarMode] call FUNC(createVehicleMarker);
	private _heliMarkersStandBy = [_heliesStandBy, "b_air", false, _radarSide, _radarMode] call FUNC(createVehicleMarker);
	_weaponMarkers = [_trackedWeapons, "b_plane", true, _radarSide, _radarMode] call FUNC(createWeaponMarker);
	_antiAirMarkers = [_SAMlaunchers, "b_antiair", false, _radarSide, _radarMode] call FUNC(createAntiAirMarker);

	_trailMarkers = _vehicleTarils + _weaponTrails;
	_vehicleMarkers = _planeMarkersModeC + _planeMarkersStandBy + _planeMarkersBogie + _heliMarkersModeC + _heliMarkersStandBy + _heliMarkersBogie;

	_radarTime = time;
};

_monitor setVariable [QGVAR(radarData), [time, _radarTime, _trailLog, _trailMarkers, _vehicleMarkers, _weaponMarkers, _antiAirMarkers]];

// ACE_map capability
if (EGVAR(main,hasACEMap)) then {
	{
		_x setVariable ["ace_map_hideBlueForceMarker", (vehicle _x) in (_planes + _helies)];
	} forEach allPlayers;
};

// update marker line spacing
[_vehicleMarkers + _weaponMarkers] call FUNC(updateMarkerSpacing);
