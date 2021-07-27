#include "script_component.hpp"

if !(player getVariable [QGVAR(isUsingRadar), false]) exitWith {};

params ["_units", "_pos", "_alt", "_shift"];

private _radarParam = player getVariable [QGVAR(radarParam), [player]];
private _vehiclesGCI = (_radarParam select 0) getVariable [QGVAR(vehiclesGCI), [[], []]];
private _dataGCI = (_radarParam select 0) getVariable [QGVAR(dataGCI), [[], [], []]];

_vehiclesGCI params ["_markersKnown", "_markersUnknown"];
_dataGCI params ["_blueGCI", "_redGCI", "_lineGCI"];

private _radarMarkers = _markersKnown + _markersUnknown;
private _markerPosList = _radarMarkers apply {_x select 1};
private _markerVehicleList = _radarMarkers apply {_x select 2};

private _distanceList = _markerPosList apply {_x distance2D _pos};
private _minDistance = selectMin _distanceList;
private _scaleNow = ctrlMapScale ((findDisplay 12) displayCtrl 51);

if (_minDistance > _scaleNow) exitWith {};

private _minIndex = _distanceList find _minDistance;
private _position = _markerPosList select _minIndex;
private _vehicle = _markerVehicleList select _minIndex;

if (_vehicle getVariable [QGVAR(selectedGCI), false]) exitWith {
	_vehicle setVariable [QGVAR(selectedGCI), false];
};

private "_circle";
if (_vehicle in (_markersKnown apply {_x select 2})) then {
	_circle = [_position, _vehicle, "ColorWEST"] call FUNC(drawMarkerGCI);
	_blueGCI pushBack _circle;
	{
		_lineGCI pushBack ([_circle, _x] call FUNC(drawLineGCI));
	} forEach _redGCI;
else {
	_circle = [_position, _vehicle, "ColorEAST"] call FUNC(drawMarkerGCI);
	_redGCI pushBack _circle;
	{
		_lineGCI pushBack ([_x, _circle] call FUNC(drawLineGCI));
	} forEach _blueGCI;
};

_vehicle setVariable [QGVAR(selectedGCI), true];
(_radarParam select 0) setVariable [QGVAR(dataGCI), [_blueGCI, _redGCI, _lineGCI]];
