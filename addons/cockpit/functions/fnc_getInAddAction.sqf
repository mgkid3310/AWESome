#include "script_component.hpp"

params ["_unit", "_position", "_vehicle", "_turret"];

private _hasAction = _vehicle getVariable [QGVAR(hasAction), false];
if (_hasAction || !(_vehicle isKindOf "Plane")) exitWith {};

_vehicle addAction ["Open Checklist", QUOTE([GVAR(lastChecklist)] call FUNC(openChecklist)), nil, 1.0151, false, true, "", QUOTE(([nil, _target, 1] call EFUNC(main,isCrew)) && (GVAR(currentChecklist) isEqualTo 'none')), 100];
_vehicle addAction ["Next Checklist", QUOTE([true] call FUNC(nextChecklist)), nil, 1.0152, false, true, "", QUOTE(([nil, _target, 1] call EFUNC(main,isCrew)) && !(GVAR(currentChecklist) isEqualTo 'none')), 100];
_vehicle addAction ["Previouse Checklist", QUOTE([false] call FUNC(nextChecklist)), nil, 1.0153, false, true, "", QUOTE(([nil, _target, 1] call EFUNC(main,isCrew)) && !(GVAR(currentChecklist) isEqualTo 'none')), 100];
_vehicle addAction ["Close Checklist", QUOTE(['none'] call FUNC(openChecklist)), nil, 1.0154, false, true, "", QUOTE(([nil, _target, 1] call EFUNC(main,isCrew)) && !(GVAR(currentChecklist) isEqualTo 'none')), 100];
_vehicle setVariable [QGVAR(hasAction), true, true];
