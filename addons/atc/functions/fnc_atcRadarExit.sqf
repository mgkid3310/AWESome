#include "script_component.hpp"

params ["_monitor", "_controller", "_trailMarkers", "_vehicleMarkers"];

{
	deleteMarkerLocal _x;
} forEach _trailMarkers;

{
	_x params ["_marker0", "_marker1", "_marker2", "_marker3", "_marker4"];
	deleteMarkerLocal _marker0;
	deleteMarkerLocal _marker1;
	deleteMarkerLocal _marker2;
	deleteMarkerLocal _marker3;
	deleteMarkerLocal _marker4;
} forEach _vehicleMarkers;

if (EGVAR(main,hasACEMap)) then {
	{
		_x setVariable ["ace_map_hideBlueForceMarker", false];
	} forEach allPlayers;
};

if ((_controller distance _monitor) > 10) then {
	[parseText format["<t align='center'>Became too far from the Radar Screen</t>"], [0.25, 1, 0.5, 0.05], [1, 1], 2] spawn BIS_fnc_textTiles;
};

_monitor setVariable [QGVAR(radarData), nil];
_controller setVariable [QGVAR(isUsingRadar), false];
_controller setVariable [QGVAR(exitRadar), false];
