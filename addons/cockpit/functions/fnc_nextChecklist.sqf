private _isNext = param [0, true];

private _indexNow = awesome_cockpit_checklistArray find awesome_cockpit_currentChecklist;
private _indexNext = (_indexNow + ([5, 7] select _isNext)) mod 6;

230 cutRsc ["none", "PLAIN"];
[awesome_cockpit_checklistArray select _indexNext] call awesome_cockpit_fnc_openChecklist;
