#include "script_component.hpp"

private _isNext = param [0, true];

private _indexNow = GVAR(checklistArray) find GVAR(currentChecklist);
private _indexNext = (_indexNow + ([5, 7] select _isNext)) mod 6;

230 cutRsc ["none", "PLAIN"];
[GVAR(checklistArray) select _indexNext] call FUNC(openChecklist);
