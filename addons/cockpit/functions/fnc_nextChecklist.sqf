#include "script_component.hpp"

params [["_skipPages", 1]];

private _indexNow = GVAR(checklistArray) find GVAR(currentChecklist);
private _indexNext = (_indexNow + _skipPages) mod 6;

230 cutRsc ["none", "PLAIN"];
[GVAR(checklistArray) select _indexNext] call FUNC(openChecklist);
