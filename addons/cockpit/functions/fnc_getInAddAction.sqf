#include "script_component.hpp"

params ["_unit", "_position", "_vehicle", "_turret"];

private _hasAction = _vehicle getVariable [QGVAR(hasAction), false];
if (_hasAction || !(_vehicle isKindOf "Plane")) exitWith {};

_vehicle addAction [localize LSTRING(openChecklist01), {[GVAR(lastChecklist)] call FUNC(openChecklist)}, nil, 1.0151, false, true, "", "([_this, _target, 1] call orbis_main_fnc_isCrew) && ('orbis_cockpit_currentChecklist' isEqualTo 'none')", 100];
_vehicle addAction [localize LSTRING(nextChecklist), {[1] call FUNC(nextChecklist)}, nil, 1.0152, false, true, "", "([_this, _target, 1] call orbis_main_fnc_isCrew) && !('orbis_cockpit_currentChecklist' isEqualTo 'none')", 100];
_vehicle addAction [localize LSTRING(prevChecklist), {[-1] call FUNC(nextChecklist)}, nil, 1.0153, false, true, "", "([_this, _target, 1] call orbis_main_fnc_isCrew) && !('orbis_cockpit_currentChecklist' isEqualTo 'none')", 100];
_vehicle addAction [localize LSTRING(closeChecklist), {["none"] call FUNC(openChecklist)}, nil, 1.0154, false, true, "", "([_this, _target, 1] call orbis_main_fnc_isCrew) && !('orbis_cockpit_currentChecklist' isEqualTo 'none')", 100];

_vehicle setVariable [QGVAR(hasAction), true];
