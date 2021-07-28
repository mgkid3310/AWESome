#include "script_component.hpp"

params ["_blue", "_red"];
_blue params ["_circleBlue", "_posBlue", "_vehicleBlue"];
_red params ["_circleRed", "_posRed", "_vehicleRed"];

private _scaleNow = ctrlMapScale ((findDisplay 12) displayCtrl 51);
private _position = (_posRed vectorAdd _posBlue) vectorMultiply 0.5;
private _vector = _posRed vectorDiff _posBlue;
private _distance = _posRed distance2D _posBlue;
private _direction = _vector call CBA_fnc_vectDir;

private _bearing = round _direction;
if (_bearing isEqualTo 0) then {_bearing = 360};
private _radialSpeed = (velocity _vehicleRed vectorDiff velocity _vehicleBlue) vectorDotProduct vectorNormalized _vector;
private _altDiff = (getPosASL _vehicleRed select 2) - (getPosASL _vehicleBlue select 2);
private _vRelSpeed = (velocity _vehicleRed select 2) - (velocity _vehicleBlue select 2);

private _markerIndexGCI = missionNameSpace getVariable [QGVAR(markerIndexGCI), 0];
missionNameSpace setVariable [QGVAR(markerIndexGCI), _markerIndexGCI + 1];

private _line = createMarkerLocal [format ["orbis_gci_%1_0", _markerIndexGCI], _position];
_line setMarkerShapeLocal "RECTANGLE";
_line setMarkerColorLocal "ColorWEST";
_line setMarkerSizeLocal [GVAR(lineWidth) * _scaleNow, ((_distance / 2) - (GVAR(circleRadius) * _scaleNow)) max 0];
_line setMarkerDirLocal _direction;

private _marker1 = createMarkerLocal [format ["orbis_gci_%1_1", _markerIndexGCI], _position];
_marker1 setMarkerTypeLocal "hd_dot_noShadow";
_marker1 setMarkerColorLocal "ColorWEST";
_marker1 setMarkerSizeLocal [0, 0];
_marker1 setMarkerTextLocal str _bearing;

private _marker2 = createMarkerLocal [format ["orbis_gci_%1_2", _markerIndexGCI], _position];
_marker2 setMarkerTypeLocal "hd_dot_noShadow";
_marker2 setMarkerColorLocal "ColorWEST";
_marker2 setMarkerSizeLocal [0, 0];
_marker2 setMarkerTextLocal format ["%1km %2m/s", [_distance / 1000, 1] call BIS_fnc_cutDecimals, round _radialSpeed];

private _marker3 = createMarkerLocal [format ["orbis_gci_%1_3", _markerIndexGCI], _position];
_marker3 setMarkerTypeLocal "hd_dot_noShadow";
_marker3 setMarkerColorLocal "ColorWEST";
_marker3 setMarkerSizeLocal [0, 0];
_marker3 setMarkerTextLocal format ["%1m %2m/s", round _altDiff, round _vRelSpeed];

[[_line, _marker1, _marker2, _marker3, _marker4], _position, [_vehicleBlue, _vehicleRed]]
