params ["_unit", "_position", "_vehicle", "_turret"];

private _hasAction = _vehicle getVariable ["orbis_cockpit_hasAction", false];
if (_hasAction || !(_vehicle isKindOf "Plane")) exitWith {};

_vehicle addAction ["Open Checklist", "[orbis_cockpit_lastChecklist] call orbis_cockpit_fnc_openChecklist", nil, 1, false, true, "", "([nil, _target, 1] call orbis_awesome_fnc_isCrew) && (orbis_cockpit_currentChecklist isEqualTo 'none')", 100];
_vehicle addAction ["Next Checklist", "[true] call orbis_cockpit_fnc_nextChecklist", nil, 1, false, true, "", "([nil, _target, 1] call orbis_awesome_fnc_isCrew) && !(orbis_cockpit_currentChecklist isEqualTo 'none')", 100];
_vehicle addAction ["Previouse Checklist", "[false] call orbis_cockpit_fnc_nextChecklist", nil, 1, false, true, "", "([nil, _target, 1] call orbis_awesome_fnc_isCrew) && !(orbis_cockpit_currentChecklist isEqualTo 'none')", 100];
_vehicle addAction ["Close Checklist", "['none'] call orbis_cockpit_fnc_openChecklist", nil, 1, false, true, "", "([nil, _target, 1] call orbis_awesome_fnc_isCrew) && !(orbis_cockpit_currentChecklist isEqualTo 'none')", 100];
_vehicle setVariable ["orbis_cockpit_hasAction", true, true];
