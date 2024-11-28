#include "script_component.hpp"

params ["_position", "_vehicle", "_color"];

private _markerIndexGCI = missionNamespace getVariable [QGVAR(markerIndexGCI), 0];
missionNamespace setVariable [QGVAR(markerIndexGCI), _markerIndexGCI + 1];

private _circle = createMarkerLocal [format ["orbis_gci_%1_0", _markerIndexGCI], _position];
_circle setMarkerTypeLocal "mil_circle_noShadow";
_circle setMarkerColorLocal _color;

[[_circle], _position, _vehicle]
