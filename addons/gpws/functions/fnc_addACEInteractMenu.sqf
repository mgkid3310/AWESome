#include "script_component.hpp"

// GPWS parent action
private _actionGPWSmodes = [
	"actionGPWS",
	"GPWS",
	"",
	{},
	{([_player, _target, 1] call EFUNC(main,isCrew)) && (_target getVariable [QGVAR(isGPWSenabled), false])},
	{},
	[],
	[0, 0, 0],
	10
];

// turn GPWS off
private _actionTurnOff = [
	"turnOff",
	"Turn off GPWS",
	"",
	{_target setVariable [QGVAR(GPWSmode), "off", true]},
	{(_target getVariable [QGVAR(GPWSmodeLocal), "off"] != "off")},
	{},
	[],
	[0, 0, 0],
	10
];

// set mode action
private _actionB747 = [
	"b747",
	"Set to B747 GPWS",
	"",
	{_target setVariable [QGVAR(GPWSmode), "b747", true]},
	{(_target getVariable [QGVAR(GPWSmodeLocal), "off"] != "b747")},
	{},
	[],
	[0, 0, 0],
	10
];
private _actionF16 = [
	"f16",
	"Set to Betty (F-16)",
	"",
	{_target setVariable [QGVAR(GPWSmode), "f16", true]},
	{(_target getVariable [QGVAR(GPWSmodeLocal), "off"] != "f16")},
	{},
	[],
	[0, 0, 0],
	10
];
private _actionRita = [
	"rita",
	"Set to Rita",
	"",
	{_target setVariable [QGVAR(GPWSmode), "rita", true]},
	{(_target getVariable [QGVAR(GPWSmodeLocal), "off"] != "rita")},
	{},
	[],
	[0, 0, 0],
	10
];

// test action
private _testB747 = [
	"f16Test",
	"Test GPWS (B747)",
	"",
	{[_target] spawn FUNC(b747GPWStest)},
	{(_target getVariable [QGVAR(GPWSmodeLocal), "off"] isEqualTo "b747") && (_target getVariable [QGVAR(GPWStestReady), true])},
	{},
	[],
	[0, 0, 0],
	10
];
private _testF16 = [
	"f16Test",
	"Test GPWS (Betty)",
	"",
	{[_target] spawn FUNC(f16GPWStest)},
	{(_target getVariable [QGVAR(GPWSmodeLocal), "off"] isEqualTo "f16") && (_target getVariable [QGVAR(GPWStestReady), true])},
	{},
	[],
	[0, 0, 0],
	10
];
private _testRita = [
	"ritaTest",
	"Test GPWS (Rita)",
	"",
	{[_target] spawn FUNC(ritaGPWStest)},
	{(_target getVariable [QGVAR(GPWSmodeLocal), "off"] isEqualTo "rita") && (_target getVariable [QGVAR(GPWStestReady), true])},
	{},
	[],
	[0, 0, 0],
	10
];

// stop currently running GPWS test
private _testStop = [
	"testStop",
	"Stop GPWS Test",
	"",
	{_target setVariable [QGVAR(GPWStestStop), true, true]},
	{(_target getVariable [QGVAR(GPWSmodeLocal), "off"] != "off") && !(_target getVariable [QGVAR(GPWStestReady), true]) && !(_target getVariable [QGVAR(GPWStestStop), false])},
	{},
	[],
	[0, 0, 0],
	10
];

// volume change
private _actionVolumeLow = [
	"volumeLow",
	"Lower Volume",
	"",
	{_target setVariable [QGVAR(GPWSvolumeLow), true, true]},
	{!(_target getVariable [QGVAR(GPWSvolumeLow), false])},
	{},
	[],
	[0, 0, 0],
	10
];
private _actionVolumeHigh = [
	"volumeHigh",
	"Increase Volume",
	"",
	{_target setVariable [QGVAR(GPWSvolumeLow), false, true]},
	{(_target getVariable [QGVAR(GPWSvolumeLow), false])},
	{},
	[],
	[0, 0, 0],
	10
];

// TCAS parent action
/* private _actionTCASmodes = [
	QGVAR(TCASModes),
	"TCAS",
	"",
	{},
	{([nil, nil, 1] call EFUNC(main,isCrew)) && !(_target getVariable [QGVAR(TCASmode), 0] < 0)},
	{},
	[],
	[0, 0, 0],
	10
]; */

// TCAS TA/RA TA STBY
/* private _actionTCASTARA = [
	"tcas_TARA",
	"TA/RA",
	"",
	{_target setVariable [QGVAR(tcasMode), 2, true]},
	{(_target getVariable [QGVAR(tcasMode), 0] != 2)},
	{},
	[],
	[0, 0, 0],
	10
];
private _actionTCASTA = [
	"tcas_TA",
	"TA",
	"",
	{_target setVariable [QGVAR(tcasMode), 1, true]},
	{(_target getVariable [QGVAR(tcasMode), 0] != 1)},
	{},
	[],
	[0, 0, 0],
	10
];
private _actionTCASSTBY = [
	"tcas_stby",
	"Stand by",
	"",
	{_target setVariable [QGVAR(tcasMode), 0, true]},
	{(_target getVariable [QGVAR(tcasMode), 0] != 0)},
	{},
	[],
	[0, 0, 0],
	10
]; */

// Transponder parent action
private _actionTranspondermodes = [
	QGVAR(TransponderModes),
	"Transponder",
	"",
	{},
	{([nil, nil, 1] call EFUNC(main,isCrew)) && !(_target getVariable [QGVAR(transponderMode), 0] < 0)},
	{},
	[],
	[0, 0, 0],
	10
];

// Transponder Mode C STBY off
private _actionTransponderModeC = [
	"transponder_modeC",
	"Mode C",
	"",
	{_target setVariable [QGVAR(transponderMode), 2, true]},
	{(_target getVariable [QGVAR(transponderMode), 0] != 2)},
	{},
	[],
	[0, 0, 0],
	10
];
private _actionTransponderSTBY = [
	"transponder_stby",
	"Stand By",
	"",
	{_target setVariable [QGVAR(transponderMode), 1, true]},
	{(_target getVariable [QGVAR(transponderMode), 0] != 1)},
	{},
	[],
	[0, 0, 0],
	10
];
private _actionTransponderOff = [
	"transponder_off",
	"Off",
	"",
	{_target setVariable [QGVAR(transponderMode), 0, true]},
	{(_target getVariable [QGVAR(transponderMode), 0] != 0)},
	{},
	[],
	[0, 0, 0],
	10
];

EGVAR(main,ACEInteractions) pushBack [1, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome"],
	_actionGPWSmodes,
	true
]];
EGVAR(main,ACEInteractions) pushBack [1.1, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "actionGPWS"],
	_actionTurnOff,
	true
]];

EGVAR(main,ACEInteractions) pushBack [1.21, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "actionGPWS"],
	_actionB747,
	true
]];
EGVAR(main,ACEInteractions) pushBack [1.22, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "actionGPWS"],
	_actionF16,
	true
]];
EGVAR(main,ACEInteractions) pushBack [1.23, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "actionGPWS"],
	_actionRita,
	true
]];

EGVAR(main,ACEInteractions) pushBack [1.31, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "actionGPWS"],
	_testB747,
	true
]];
EGVAR(main,ACEInteractions) pushBack [1.32, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "actionGPWS"],
	_testF16,
	true
]];
EGVAR(main,ACEInteractions) pushBack [1.33, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "actionGPWS"],
	_testRita,
	true
]];
EGVAR(main,ACEInteractions) pushBack [1.34, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "actionGPWS"],
	_testStop,
	true
]];

EGVAR(main,ACEInteractions) pushBack [1.41, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "actionGPWS"],
	_actionVolumeLow,
	true
]];
EGVAR(main,ACEInteractions) pushBack [1.42, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "actionGPWS"],
	_actionVolumeHigh,
	true
]];

/* EGVAR(main,ACEInteractions) pushBack [2, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome"],
	_actionTCASmodes,
	true
]];
EGVAR(main,ACEInteractions) pushBack [2.1, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", QGVAR(TCASModes)],
	_actionTCASTARA,
	true
]];
EGVAR(main,ACEInteractions) pushBack [2.2, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", QGVAR(TCASModes)],
	_actionTCASTA,
	true
]];
EGVAR(main,ACEInteractions) pushBack [2.3, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", QGVAR(TCASModes)],
	_actionTCASSTBY,
	true
]]; */

EGVAR(main,ACEInteractions) pushBack [3, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome"],
	_actionTranspondermodes,
	true
]];
EGVAR(main,ACEInteractions) pushBack [3.1, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", QGVAR(TransponderModes)],
	_actionTransponderModeC,
	true
]];
EGVAR(main,ACEInteractions) pushBack [3.2, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", QGVAR(TransponderModes)],
	_actionTransponderSTBY,
	true
]];
EGVAR(main,ACEInteractions) pushBack [3.3, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", QGVAR(TransponderModes)],
	_actionTransponderOff,
	true
]];
