#include "script_component.hpp"

private _actionATISmain = [
	"actionATIS",
	"ATIS",
	"",
	{},
	{[] call EFUNC(main,isCrew)},
	{},
	[],
	[0, 0, 0],
	10
];
private _actionATISlisten = [
	"startATIS",
	"Listen to ATIS",
	"",
	{[] call FUNC(listenATISbroadcast)},
	{([] call EFUNC(main,isCrew)) && (_target getVariable [QGVAR(isATISready), true])},
	{},
	[],
	[0, 0, 0],
	10
];
private _actionATISstop = [
	"stopATIS",
	"Stop Listening ATIS",
	"",
	{_target setVariable [QGVAR(stopATIS), true, true]},
	{([] call EFUNC(main,isCrew)) && !(_target getVariable [QGVAR(stopATIS), true])},
	{},
	[],
	[0, 0, 0],
	10
];

// planes
EGVAR(main,ACEInteractions) pushBack [4, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome"],
	_actionATISmain,
	true
]];
EGVAR(main,ACEInteractions) pushBack [4.1, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "actionATIS"],
	_actionATISlisten,
	true
]];
EGVAR(main,ACEInteractions) pushBack [4.2, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "actionATIS"],
	_actionATISstop,
	true
]];

// helicopters
EGVAR(main,ACEInteractions) pushBack [4, [
	"Helicopter",
	1,
	["ACE_SelfActions", "AWESome"],
	_actionATISmain,
	true
]];
EGVAR(main,ACEInteractions) pushBack [4.1, [
	"Helicopter",
	1,
	["ACE_SelfActions", "AWESome", "actionATIS"],
	_actionATISlisten,
	true
]];
EGVAR(main,ACEInteractions) pushBack [4.2, [
	"Helicopter",
	1,
	["ACE_SelfActions", "AWESome", "actionATIS"],
	_actionATISstop,
	true
]];
