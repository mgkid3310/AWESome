private _isNext = param [0, true];

private _indexNow = orbis_cockpit_checklistArray find orbis_cockpit_currentChecklist;
private _indexNext = (_indexNow + ([5, 7] select _isNext)) mod 6;

230 cutRsc ["none", "PLAIN"];
[orbis_cockpit_checklistArray select _indexNext] call orbis_cockpit_fnc_openChecklist;
