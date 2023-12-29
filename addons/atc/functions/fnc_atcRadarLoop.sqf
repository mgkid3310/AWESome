#include "script_component.hpp"

params ["_monitor", ["_controller", player], ["_radarMode", 1], ["_distance", 10]];

private _radarData = _monitor getVariable [QGVAR(radarData), [0, 0, [], [], [], [], []]];
_radarData params ["_timeOld", "_radarTime", "_trailLog", "_trailMarkers", "_vehicleMarkers", "_weaponMarkers", "_antiAirMarkers"];

private _dataGCI = _monitor getVariable [QGVAR(dataGCI), [[], [], []]];
_dataGCI params ["_blueGCI", "_redGCI", "_lineGCI"];

private _allMarkers = _vehicleMarkers + _weaponMarkers + _antiAirMarkers + _blueGCI + _redGCI + _lineGCI;

if (!(alive _controller) || (_controller getVariable [QGVAR(exitRadar), false])) exitWith {
	[_monitor, _controller, _distance, _trailMarkers, _allMarkers] call FUNC(atcRadarExit);
};

if ((_distance > 0) && ((_controller distance _monitor) > _distance)) exitWith {
	[_monitor, _controller, _distance, _trailMarkers, _allMarkers] call FUNC(atcRadarExit);
};

if !(time > _timeOld) exitWith {};

private _radarSide = side _controller;
private _isObserver = (_controller getVariable [QGVAR(isObserver), false]) || (_radarMode isEqualTo 2);
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

	private ["_planesUnknown", "_heliesUnknown", "_planesRogue", "_heliesRogue", "_planesBogie", "_heliesBogie", "_planesBandit", "_heliesBandit"];
	if (!_isObserver && (_radarMode > 0)) then {
		_planesUnknown = (_allPlanes - _planesKnown) apply {[_x, [_monitor, _x] call FUNC(simulateRadarDetection)]};
		_heliesUnknown = (_allHelies - _heliesKnown) apply {[_x, [_monitor, _x] call FUNC(simulateRadarDetection)]};

		_planesRogue = _planesKnown select {_radarSide in (_x getVariable [QGVAR(isHostileTo), []])};
		_heliesRogue = _heliesKnown select {_radarSide in (_x getVariable [QGVAR(isHostileTo), []])};
		_planesKnown = _planesKnown - _planesRogue;
		_heliesKnown = _heliesKnown - _heliesRogue;

		_planesBogie = _planesUnknown select {((_x select 1) > 1) && !(_radarSide in ((_x select 0) getVariable [QGVAR(isHostileTo), []]))};
		_heliesBogie = _heliesUnknown select {((_x select 1) > 1) && !(_radarSide in ((_x select 0) getVariable [QGVAR(isHostileTo), []]))};
		_planesBandit = _planesUnknown select {((_x select 1) > 1) && (_radarSide in ((_x select 0) getVariable [QGVAR(isHostileTo), []]))};
		_heliesBandit = _heliesUnknown select {((_x select 1) > 1) && (_radarSide in ((_x select 0) getVariable [QGVAR(isHostileTo), []]))};
	} else {
		_planesUnknown = [];
		_heliesUnknown = [];

		_planesRogue = [];
		_heliesRogue = [];

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

	private _antiAirVehicles = [];
	if !(_isObserver) then {
		_antiAirVehicles = _antiAirVehicles select {(side _x) isEqualTo _radarSide};
	};

	private _additionalSAMs = missionNameSpace getVariable [QGVAR(additionalSAMs), []];
	{
		_antiAirVehicles pushBackUnique _x;
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
	} forEach (_planesModeC + _heliesModeC + _planesRogue + _heliesRogue + ((_planesBogie + _heliesBogie + _planesBandit + _heliesBandit + _trailWeapons) apply {_x select 0}));

	{
		deleteMarkerLocal _x;
	} forEach _trailMarkers;

	{
		{
			deleteMarkerLocal _x;
		} forEach (_x select 0);
	} forEach _allMarkers;

	private _trailsModeC = [_trailLog, _planesModeC + _heliesModeC, _radarSide, _targetType] call FUNC(createVehicleTrails);
	private _trailsRogue = [_trailLog, _planesRogue + _heliesRogue, _radarSide, 2] call FUNC(createVehicleTrails);
	private _trailsBogie = [_trailLog, _planesBogie + _heliesBogie, _radarSide, 1] call FUNC(createVehicleTrails);
	private _trailsBandit = [_trailLog, _planesBandit + _heliesBandit, _radarSide, 2] call FUNC(createVehicleTrails);
	private _weaponTrails = [_trailLog, _trailWeapons, _radarSide, _targetType] call FUNC(createWeaponTrails);

	private _planeMarkersModeC = [_planesModeC, "b_plane", true, _radarSide, _targetType] call FUNC(createVehicleMarker);
	private _heliMarkersModeC = [_heliesModeC, "b_air", true, _radarSide, _targetType] call FUNC(createVehicleMarker);
	private _planeMarkersStandBy = [_planesStandBy, "b_plane", false, _radarSide, _targetType] call FUNC(createVehicleMarker);
	private _heliMarkersStandBy = [_heliesStandBy, "b_air", false, _radarSide, _targetType] call FUNC(createVehicleMarker);
	private _markersKnown = _planeMarkersModeC + _heliMarkersModeC + _planeMarkersStandBy + _heliMarkersStandBy;

	private _planeMarkersRogue = [_planesRogue, "b_plane", true, _radarSide, 2, 0] call FUNC(createVehicleMarker);
	private _heliMarkersRogue = [_heliesRogue, "b_air", true, _radarSide, 2, 0] call FUNC(createVehicleMarker);
	private _planeMarkersBogie = [_planesBogie, "b_plane", true, _radarSide, 1] call FUNC(createVehicleMarker);
	private _heliMarkersBogie = [_heliesBogie, "b_air", true, _radarSide, 1] call FUNC(createVehicleMarker);
	private _planeMarkersBandit = [_planesBandit, "b_plane", true, _radarSide, 2] call FUNC(createVehicleMarker);
	private _heliMarkersBandit = [_heliesBandit, "b_air", true, _radarSide, 2] call FUNC(createVehicleMarker);
	private _markersUnknown = _planeMarkersRogue + _heliMarkersRogue + _planeMarkersBogie + _heliMarkersBogie + _planeMarkersBandit + _heliMarkersBandit;

	private _knownWeaponMarkers = [_knownWeapons, "b_plane", true, _radarSide, _targetType] call FUNC(createWeaponMarker);
	private _bogieWeaponMarkers = [_bogieWeapons, "b_plane", true, _radarSide, 1] call FUNC(createWeaponMarker);
	private _banditWeaponMarkers = [_banditWeapons, "b_plane", true, _radarSide, 2] call FUNC(createWeaponMarker);
	_weaponMarkers = _knownWeaponMarkers + _bogieWeaponMarkers + _banditWeaponMarkers;

	_antiAirMarkers = [_antiAirVehicles, "b_antiair", false, _radarSide, _targetType] call FUNC(createAntiAirMarker);

	private ["_blueVehicles", "_rogueVehicles", "_bogieVehicles", "_banditVehicles"];
	private ["_blueTargets", "_rogueTargets", "_bogieTargets", "_banditTargets"];
	private ["_allGCI", "_rogueGCI", "_bogieGCI", "_banditGCI"];
	if (_radarMode isEqualTo 1) then {
		_blueVehicles = _planesModeC + _heliesModeC + _planesStandBy + _heliesStandBy;
		_rogueVehicles = _planesRogue + _heliesRogue;
		_bogieVehicles = (_planesBogie + _heliesBogie) apply {_x select 0};
		_banditVehicles = (_planesBandit + _heliesBandit) apply {_x select 0};

		_allGCI = (_blueGCI + _redGCI) apply {_x select 2};

		_blueTargets = _allGCI select {_x in _blueVehicles};
		_rogueTargets = _allGCI select {_x in _rogueVehicles};
		_bogieTargets = _allGCI select {_x in _bogieVehicles};
		_banditTargets = _allGCI select {_x in _banditVehicles};

		_blueGCI = [_blueTargets, _radarSide, 0] call FUNC(createMarkerGCI);
		_rogueGCI = [_rogueTargets, _radarSide, 2] call FUNC(createMarkerGCI);
		_bogieGCI = [_bogieTargets, _radarSide, 1] call FUNC(createMarkerGCI);
		_banditGCI = [_banditTargets, _radarSide, 2] call FUNC(createMarkerGCI);

		_redGCI = _rogueGCI + _bogieGCI + _banditGCI;
		_lineGCI = [_blueGCI, _redGCI] call FUNC(createLineGCI);
	} else {
		_blueGCI = [];
		_redGCI = [];
		_lineGCI = [];
	};

	_monitor setVariable [QGVAR(vehiclesGCI), [_markersKnown, _planeMarkersBogie + _heliMarkersBogie, _planeMarkersRogue + _heliMarkersRogue + _planeMarkersBandit + _heliMarkersBandit]];
	_monitor setVariable [QGVAR(dataGCI), [_blueGCI, _redGCI, _lineGCI]];

	_trailMarkers = _trailsModeC + _trailsRogue + _trailsBogie + _trailsBandit + _weaponTrails;
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

// update marker per frame
[_vehicleMarkers + _weaponMarkers + _antiAirMarkers] call FUNC(updateMarkerSpacing);

_blueGCI = [_blueGCI] call FUNC(updateMarkerGCI);
_redGCI = [_redGCI] call FUNC(updateMarkerGCI);
_lineGCI = [_lineGCI] call FUNC(updateLineGCI);
_monitor setVariable [QGVAR(dataGCI), [_blueGCI, _redGCI, _lineGCI]];
