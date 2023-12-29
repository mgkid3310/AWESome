#include "script_component.hpp"

if !(player getVariable [QGVAR(isUsingRadar), false]) exitWith {};

params ["_units", "_pos", "_alt", "_shift"];

private _radarParam = player getVariable [QGVAR(radarParam), [player]];
_radarParam params ["_monitor", ["_controller", player], ["_radarMode", 0]];

if ((_controller getVariable [QGVAR(isObserver), false]) || !(_radarMode isEqualTo 1)) exitWith {};

private _vehiclesGCI = _monitor getVariable [QGVAR(vehiclesGCI), [[], [], []]];
private _dataGCI = _monitor getVariable [QGVAR(dataGCI), [[], [], []]];
_vehiclesGCI params ["_markersKnown", "_markersBogie", "_markersBandit"];
_dataGCI params ["_blueGCI", "_redGCI", "_lineGCI"];

private _radarMarkers = _markersKnown + _markersBogie + _markersBandit;
private _markerPosList = _radarMarkers apply {_x select 1};
private _markerVehicleList = _radarMarkers apply {_x select 2};

if !(count _markerPosList > 0) exitWith {};

private _distanceList = _markerPosList apply {_x distance2D _pos};
private _minDistance = selectMin _distanceList;
private _scaleNow = ctrlMapScale ((findDisplay 12) displayCtrl 51) / GVAR(scaleStd);

if (_minDistance > _scaleNow * GVAR(mapClickRange)) exitWith {};

private _minIndex = _distanceList find _minDistance;
private _position = _markerPosList select _minIndex;
private _vehicle = _markerVehicleList select _minIndex;

if (missionNameSpace getVariable [QGVAR(classifyAsHostile), false]) exitWith {
	[_vehicle, side _controller] call FUNC(classifyAsHostile);
};

if (_vehicle getVariable [QGVAR(selectedGCI), false]) exitWith {
	_vehicle setVariable [QGVAR(selectedGCI), false];
};

private _targetType = 0;
switch (true) do {
	case (_vehicle in (_markersBogie apply {_x select 2})): {_targetType = 1};
	case (_vehicle in (_markersBandit apply {_x select 2})): {_targetType = 2};
	default {};
};

private _markerColor = [side driver _vehicle, side _controller, _targetType] call FUNC(getRadarMarkerColor);
private _circle = [_position, _vehicle, _markerColor] call FUNC(drawMarkerGCI);;
if (_vehicle in (_markersKnown apply {_x select 2})) then {
	_blueGCI pushBack _circle;
	{
		_lineGCI pushBack ([_circle, _x] call FUNC(drawLineGCI));
	} forEach _redGCI;
} else {
	_redGCI pushBack _circle;
	{
		_lineGCI pushBack ([_x, _circle] call FUNC(drawLineGCI));
	} forEach _blueGCI;
};

_vehicle setVariable [QGVAR(selectedGCI), true];
(_radarParam select 0) setVariable [QGVAR(dataGCI), [_blueGCI, _redGCI, _lineGCI]];
