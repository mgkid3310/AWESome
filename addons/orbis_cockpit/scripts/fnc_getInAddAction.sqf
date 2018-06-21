params ["_unit", "_position", "_vehicle", "_turret"];

private _hasAction = _vehicle getVariable ["orbis_cockpit_hasAction", false];
if (_hasAction || !(_vehicle isKindOf "Plane")) exitWith {};

_vehicle addAction ["Open Checklist", "['pre_start_checklist'] call orbis_cockpit_fnc_openChecklist", nil, 1, false, true, "", "(isClass (configFile >> 'CfgPatches' >> 'orbis_cockpit')) && ([nil, nil, 1] call orbis_gpws_fnc_isCrew)", 100];
