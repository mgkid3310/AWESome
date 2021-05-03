#include "script_component.hpp"

params ["_monitor", ["_controller", player], ["_radarMode", 0], ["_distance", 10]];

private _loadData = _monitor getVariable [QGVAR(radarData), [0, 0, [], [], [], [], []]];
_loadData params ["_timeOld", "_radarTime", "_trailLog", "_trailMarkers", "_vehicleMarkers", "_weaponMarkers", "_antiAirMarkers"];

if (!(alive _controller) || (_controller getVariable [QGVAR(exitRadar), false])) exitWith {
	[_monitor, _controller, _distance, _trailMarkers, _vehicleMarkers + _weaponMarkers + _antiAirMarkers] call FUNC(atcRadarExit);
};

if ((_distance > 0) && ((_controller distance _monitor) > _distance)) exitWith {
	[_monitor, _controller, _distance, _trailMarkers, _vehicleMarkers + _weaponMarkers + _antiAirMarkers] call FUNC(atcRadarExit);
};

if !(time > _timeOld) exitWith {};

private _radarSide = side _controller;
private _isObserver = _controller getVariable [QGVAR(isObserver), false];
if (_radarMode isEqualTo 2) then {
	_isObserver = true;
};

private _targetType = 0;
if (_isObserver) then {
	_radarMode = -1;
	_targetType = -1;
};

private _allPlanes = (entities "Plane") select {(alive _x) && (0 < getNumber (configFile >> "CfgVehicles" >> (typeOf _x) >> "radarTarget"))};
private _allHelies = (entities "Helicopter") select {(alive _x) && (0 < getNumber (configFile >> "CfgVehicles" >> (typeOf _x) >> "radarTarget"))};

// update planes info
if (time > _radarTime + GVAR(radarUpdateInterval)) then {
	missionNameSpace setVariable [QGVAR(markerIndex), 0];

	private ["_planesKnown", "_heliesKnown"];
	if (_isObserver) then {
		_planesKnown = _allPlanes;
		_heliesKnown = _allHelies;
	} else {
		_planesKnown = _allPlanes select {(side driver _x) in [_radarSide, civilian]};
		_heliesKnown = _allHelies select {(side driver _x) in [_radarSide, civilian]};
	};

	private ["_planesUnknown", "_heliesUnknown", "_planesBogie", "_heliesBogie", "_planesBandit", "_heliesBandit"];
	if (!_isObserver && (_radarMode > 0)) then {
		_planesUnknown = (_allPlanes - _planesKnown) apply {[_x, [_monitor, _x] call FUNC(simulateRadarDetection)]};
		_heliesUnknown = (_allHelies - _heliesKnown) apply {[_x, [_monitor, _x] call FUNC(simulateRadarDetection)]};

		_planesBogie = _planesUnknown select {((_x select 1) > 1) && !(_radarSide in ((_x select 0) getVariable [QGVAR(isHostileTo), []]))};
		_heliesBogie = _heliesUnknown select {((_x select 1) > 1) && !(_radarSide in ((_x select 0) getVariable [QGVAR(isHostileTo), []]))};
		_planesBandit = _planesUnknown select {((_x select 1) > 1) && (_radarSide in ((_x select 0) getVariable [QGVAR(isHostileTo), []]))};
		_heliesBandit = _heliesUnknown select {((_x select 1) > 1) && (_radarSide in ((_x select 0) getVariable [QGVAR(isHostileTo), []]))};
	} else {
		_planesUnknown = [];
		_heliesUnknown = [];

		_planesBogie = [];
		_heliesBogie = [];
		_planesBandit = [];
		_heliesBandit = [];
	};

	private _additionalPlanes = missionNameSpace getVariable [QGVAR(additionalPlanes), []];
	private _additionalHelies = missionNameSpace getVariable [QGVAR(additionalHelies), []];
	{
		_planesKnown pushBackUnique _x;
	} forEach _additionalPlanes;
	{
		_heliesKnown pushBackUnique _x;
	} forEach _additionalHelies;

	private _planesAuto = [_planesKnown] call FUNC(getAutoTransponders);
	private _heliesAuto = [_heliesKnown] call FUNC(getAutoTransponders);
	private _planesManual = _planesKnown - _planesAuto;
	private _heliesManual = _heliesKnown - _heliesAuto;

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
		_SAMlaunchers = _SAMlaunchers select {(side _x) isEqualTo _radarSide};
	};

	private _additionalSAMs = missionNameSpace getVariable [QGVAR(additionalSAMs), []];
	{
		_SAMlaunchers pushBackUnique _x;
	} forEach _additionalSAMs;

	private ["_knownWeapons", "_detectedWeapons", "_bogieWeapons", "_banditWeapons"];
	private _trackedWeapons = missionNamespace getVariable [QGVAR(trackedWeapons), []];
	if !(_isObserver) then {
		_knownWeapons = _trackedWeapons select {(_x select 2) isEqualTo _radarSide};
		_detectedWeapons = (_trackedWeapons - _knownWeapons) apply {_x + [[_monitor, _x select 0, 0.7] call FUNC(simulateRadarDetection)]};

		_bogieWeapons = _detectedWeapons select {((_x select 4) > 1) && !(_radarSide in (_x select 3))};
		_banditWeapons = _detectedWeapons select {((_x select 4) > 1) && (_radarSide in (_x select 3))};

		_trackedWeapons = _knownWeapons + _detectedWeapons;
	} else {
		_knownWeapons = _trackedWeapons;
		_bogieWeapons = [];
		_banditWeapons = [];
	};
	private _trailWeapons = [[], _trackedWeapons] select GVAR(displayProjectileTrails);

	private ["_targetObject", "_vehicleTrail", "_targetTrail"];
	private _trailLogOld = _trailLog;
	_trailLog = [];
	{
		_targetObject = _x;
		_vehicleTrail = _trailLogOld select {(_x select 0) isEqualTo _targetObject};
		_targetTrail = _vehicleTrail select {(_x select 2) + GVAR(radarTrailLength) >= time};

		if (_vehicleTrail find (_targetTrail select 0) > 0) then {
			_trailLog pushBack (_vehicleTrail select ((_vehicleTrail find (_targetTrail select 0)) - 1));
		};
		_trailLog append _targetTrail;
		_trailLog pushBack [_x, getPos _x, time];

		_trailLogOld = _trailLogOld - _vehicleTrail;
	} forEach (_planesModeC + _heliesModeC + ((_planesBogie + _heliesBogie + _planesBandit + _heliesBandit + _trailWeapons) apply {_x select 0}));

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

	private _trailsModeC = [_trailLog, _planesModeC + _heliesModeC, _radarSide, _targetType] call FUNC(createVehicleTrails);
	private _trailsBogie = [_trailLog, _planesBogie + _heliesBogie, _radarSide, 1] call FUNC(createVehicleTrails);
	private _trailsBandit = [_trailLog, _planesBandit + _heliesBandit, _radarSide, 2] call FUNC(createVehicleTrails);
	private _weaponTrails = [_trailLog, _trailWeapons, _radarSide, _targetType] call FUNC(createWeaponTrails);

	private _planeMarkersModeC = [_planesModeC, "b_plane", true, _radarSide, _targetType] call FUNC(createVehicleMarker);
	private _heliMarkersModeC = [_heliesModeC, "b_air", true, _radarSide, _targetType] call FUNC(createVehicleMarker);
	private _planeMarkersStandBy = [_planesStandBy, "b_plane", false, _radarSide, _targetType] call FUNC(createVehicleMarker);
	private _heliMarkersStandBy = [_heliesStandBy, "b_air", false, _radarSide, _targetType] call FUNC(createVehicleMarker);
	private _markersKnown = _planeMarkersModeC + _heliMarkersModeC + _planeMarkersStandBy + _heliMarkersStandBy;

	private _planeMarkersBogie = [_planesBogie, "b_plane", true, _radarSide, 1] call FUNC(createVehicleMarker);
	private _heliMarkersBogie = [_heliesBogie, "b_air", true, _radarSide, 1] call FUNC(createVehicleMarker);
	private _planeMarkersBandit = [_planesBandit, "b_plane", true, _radarSide, 2] call FUNC(createVehicleMarker);
	private _heliMarkersBandit = [_heliesBandit, "b_air", true, _radarSide, 2] call FUNC(createVehicleMarker);
	private _markersUnknown = _planeMarkersBogie + _heliMarkersBogie + _planeMarkersBandit + _heliMarkersBandit;

	private _knownWeaponMarkers = [_knownWeapons, "b_plane", true, _radarSide, _targetType] call FUNC(createWeaponMarker);
	private _bogieWeaponMarkers = [_bogieWeapons, "b_plane", true, _radarSide, 1] call FUNC(createWeaponMarker);
	private _banditWeaponMarkers = [_banditWeapons, "b_plane", true, _radarSide, 2] call FUNC(createWeaponMarker);
	_weaponMarkers = _knownWeaponMarkers + _bogieWeaponMarkers + _banditWeaponMarkers;

	_antiAirMarkers = [_SAMlaunchers, "b_antiair", false, _radarSide, _targetType] call FUNC(createAntiAirMarker);

	_trailMarkers = _trailsModeC + _trailsBogie + _trailsBandit + _weaponTrails;
	_vehicleMarkers = _markersKnown + _markersUnknown;

	_radarTime = time;
};

_monitor setVariable [QGVAR(radarData), [time, _radarTime, _trailLog, _trailMarkers, _vehicleMarkers, _weaponMarkers, _antiAirMarkers]];

// ACE_map capability
if (EGVAR(main,hasACEMap)) then {
	{
		_x setVariable ["ace_map_hideBlueForceMarker", (vehicle _x) in (_allPlanes + _allHelies)];
	} forEach allPlayers;
};

// update marker line spacing
[_vehicleMarkers + _weaponMarkers + _antiAirMarkers] call FUNC(updateMarkerSpacing);
