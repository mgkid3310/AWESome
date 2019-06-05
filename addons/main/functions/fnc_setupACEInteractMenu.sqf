#include "script_component.hpp"

private _interactionSorted = [GVAR(ACEInteractions), [], {_x select 0}, "ASCEND"] call BIS_fnc_sortBy;

private ["_action"];
{
	_action = _x select 1;
	_action set [3, (_action select 3) call ace_interact_menu_fnc_createAction];
	_action call ace_interact_menu_fnc_addActionToClass;
} forEach _interactionSorted;
