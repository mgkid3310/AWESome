#include "script_component.hpp"

params ["_monitor", "_controller", "_distance", "_trailMarkers", "_vehicleMarkers"];

{
	deleteMarkerLocal _x;
} forEach _trailMarkers;

{
	{
		deleteMarkerLocal _x;
	} forEach (_x select 0);
} forEach _vehicleMarkers;

if (EGVAR(main,hasACEMap)) then {
	{
		_x setVariable ["ace_map_hideBlueForceMarker", false];
	} forEach allPlayers;
};

if ((alive _controller) && (_distance > 0) && ((_controller distance _monitor) > _distance)) then {
	[parseText format["<t align='center'>Became too far from the Radar Screen</t>"], [0.25, 1, 0.5, 0.05], [1, 1], 2] spawn BIS_fnc_textTiles;
};

_monitor setVariable [QGVAR(radarData), nil];
_controller setVariable [QGVAR(isUsingRadar), false];
_controller setVariable [QGVAR(exitRadar), false];
