#include "script_component.hpp"

private _isATISready = (vehicle player) getVariable [QGVAR(isATISready), true];
private _lastTime = (vehicle player) getVariable [QGVAR(lastATIStime), CBA_missionTime];
if (!_isATISready && (CBA_missionTime > (_lastTime + 60))) then {
	(vehicle player) setVariable [QGVAR(isATISready), true, true];
};
