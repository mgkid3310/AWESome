params ["_unit", "_position", "_vehicle", "_turret"];

private _hasAction = _vehicle getVariable ["awesome_cockpit_hasAction", false];
if (_hasAction || !(_vehicle isKindOf "Plane")) exitWith {};

_vehicle addAction ["Open Checklist", "[awesome_cockpit_lastChecklist] call awesome_cockpit_fnc_openChecklist", nil, 1, false, true, "", "(isClass (configFile >> 'CfgPatches' >> 'awesome_cockpit')) && ([nil, nil, 1] call awesome_awesome_fnc_isCrew)", 100];
_vehicle addAction ["Next Checklist", "[true] call awesome_cockpit_fnc_nextChecklist", nil, 1, false, true, "", "(isClass (configFile >> 'CfgPatches' >> 'awesome_cockpit')) && ([nil, nil, 1] call awesome_awesome_fnc_isCrew) && !(awesome_cockpit_currentChecklist isEqualTo 'none')", 100];
_vehicle addAction ["Previouse Checklist", "[false] call awesome_cockpit_fnc_nextChecklist", nil, 1, false, true, "", "(isClass (configFile >> 'CfgPatches' >> 'awesome_cockpit')) && ([nil, nil, 1] call awesome_awesome_fnc_isCrew) && !(awesome_cockpit_currentChecklist isEqualTo 'none')", 100];
_vehicle addAction ["Close Checklist", "['none'] call awesome_cockpit_fnc_openChecklist", nil, 1, false, true, "", "(isClass (configFile >> 'CfgPatches' >> 'awesome_cockpit')) && ([nil, nil, 1] call awesome_awesome_fnc_isCrew) && !(awesome_cockpit_currentChecklist isEqualTo 'none')", 100];
_vehicle setVariable ["awesome_cockpit_hasAction", true, true];
