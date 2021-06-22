#include "script_component.hpp"

private _actionMain = [
	"AWESome",
	localize LSTRING(AWESome),
	"",
	{},
	{[_player, _target, 0] call FUNC(isCrew)},
	{},
	[],
	[0, 0, 0],
	10
];

GVAR(ACEInteractions) pushBack [0, [
	"Plane",
	1,
	["ACE_SelfActions"],
	_actionMain,
	true
]];
GVAR(ACEInteractions) pushBack [0, [
	"Helicopter",
	1,
	["ACE_SelfActions"],
	_actionMain,
	true
]];
