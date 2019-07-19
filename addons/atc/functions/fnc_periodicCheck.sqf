#include "script_component.hpp"

private _isATISready = (vehicle player) getVariable [QGVAR(isATISready), true];
private _lastTime = (vehicle player) getVariable [QGVAR(lastATIStime), CBA_missionTime];
if (!_isATISready && (CBA_missionTime > (_lastTime + 60))) then {
	(vehicle player) setVariable [QGVAR(isATISready), true, true];
};

private _trackedWeapons = missionNamespace getVariable [QGVAR(trackedWeapons), []];
_trackedWeapons = _trackedWeapons select {(alive (_x select 0)) && (getPosASL (_x select 0) select 2 > 1)};
missionNamespace setVariable [QGVAR(trackedWeapons), _trackedWeapons];
