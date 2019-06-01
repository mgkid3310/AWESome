// GPWS parent action
private _actionGPWSmodes = [
	"orbis_gpws_GPWSmodes",
	"GPWS",
	"",
	{},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && (_target getVariable ["orbis_gpws_GPWSenabled", false])},
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
	{_target setVariable ["orbis_gpws_GPWSmode", "off", true]},
	{(_target getVariable ["orbis_gpws_GPWSmodeLocal", "off"] != "off")},
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
	{_target setVariable ["orbis_gpws_GPWSmode", "b747", true]},
	{(_target getVariable ["orbis_gpws_GPWSmodeLocal", "off"] != "b747")},
	{},
	[],
	[0, 0, 0],
	10
];
private _actionF16 = [
	"f16",
	"Set to Betty (F-16)",
	"",
	{_target setVariable ["orbis_gpws_GPWSmode", "f16", true]},
	{(_target getVariable ["orbis_gpws_GPWSmodeLocal", "off"] != "f16")},
	{},
	[],
	[0, 0, 0],
	10
];
private _actionRita = [
	"rita",
	"Set to Rita",
	"",
	{_target setVariable ["orbis_gpws_GPWSmode", "rita", true]},
	{(_target getVariable ["orbis_gpws_GPWSmodeLocal", "off"] != "rita")},
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
	{[_target] spawn orbis_gpws_fnc_b747GPWStest},
	{(_target getVariable ["orbis_gpws_GPWSmodeLocal", "off"] isEqualTo "b747") && (_target getVariable ["orbis_gpws_GPWStestReady", true])},
	{},
	[],
	[0, 0, 0],
	10
];
private _testF16 = [
	"f16Test",
	"Test GPWS (Betty)",
	"",
	{[_target] spawn orbis_gpws_fnc_f16GPWStest},
	{(_target getVariable ["orbis_gpws_GPWSmodeLocal", "off"] isEqualTo "f16") && (_target getVariable ["orbis_gpws_GPWStestReady", true])},
	{},
	[],
	[0, 0, 0],
	10
];
private _testRita = [
	"ritaTest",
	"Test GPWS (Rita)",
	"",
	{[_target] spawn orbis_gpws_fnc_ritaGPWStest},
	{(_target getVariable ["orbis_gpws_GPWSmodeLocal", "off"] isEqualTo "rita") && (_target getVariable ["orbis_gpws_GPWStestReady", true])},
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
	{_target setVariable ["orbis_gpws_GPWStestStop", true, true]},
	{(_target getVariable ["orbis_gpws_GPWSmodeLocal", "off"] != "off") && !(_target getVariable ["orbis_gpws_GPWStestReady", true]) && !(_target getVariable ["orbis_gpws_GPWStestStop", false])},
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
	{_target setVariable ["orbis_gpws_GPWSvolumeLow", true, true]},
	{!(_target getVariable ["orbis_gpws_GPWSvolumeLow", false])},
	{},
	[],
	[0, 0, 0],
	10
];
private _actionVolumeHigh = [
	"volumeHigh",
	"Increase Volume",
	"",
	{_target setVariable ["orbis_gpws_GPWSvolumeLow", false, true]},
	{(_target getVariable ["orbis_gpws_GPWSvolumeLow", false])},
	{},
	[],
	[0, 0, 0],
	10
];

// TCAS parent action
private _actionTCASmodes = [
	"orbis_gpws_TCASModes",
	"TCAS",
	"",
	{},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && !(_target getVariable ["orbis_gpws_TCASmode", 0] < 0)},
	{},
	[],
	[0, 0, 0],
	10
];

// TCAS TA/RA TA STBY
private _actionTCASTARA = [
	"tcas_TARA",
	"TA/RA",
	"",
	{_target setVariable ["orbis_gpws_tcasMode", 2, true]},
	{(_target getVariable ["orbis_gpws_tcasMode", 0] != 2)},
	{},
	[],
	[0, 0, 0],
	10
];
private _actionTCASTA = [
	"tcas_TA",
	"TA",
	"",
	{_target setVariable ["orbis_gpws_tcasMode", 1, true]},
	{(_target getVariable ["orbis_gpws_tcasMode", 0] != 1)},
	{},
	[],
	[0, 0, 0],
	10
];
private _actionTCASSTBY = [
	"tcas_stby",
	"Stand by",
	"",
	{_target setVariable ["orbis_gpws_tcasMode", 0, true]},
	{(_target getVariable ["orbis_gpws_tcasMode", 0] != 0)},
	{},
	[],
	[0, 0, 0],
	10
];

// Transponder parent action
private _actionTranspondermodes = [
	"orbis_gpws_TransponderModes",
	"TCAS",
	"",
	{},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && !(_target getVariable ["orbis_gpws_transponderMode", 0] < 0)},
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
	{_target setVariable ["orbis_gpws_transponderMode", 2, true]},
	{(_target getVariable ["orbis_gpws_transponderMode", 0] != 2)},
	{},
	[],
	[0, 0, 0],
	10
];
private _actionTransponderSTBY = [
	"transponder_stby",
	"Stand By",
	"",
	{_target setVariable ["orbis_gpws_transponderMode", 1, true]},
	{(_target getVariable ["orbis_gpws_transponderMode", 0] != 1)},
	{},
	[],
	[0, 0, 0],
	10
];
private _actionTransponderOff = [
	"transponder_off",
	"Off",
	"",
	{_target setVariable ["orbis_gpws_transponderMode", 0, true]},
	{(_target getVariable ["orbis_gpws_transponderMode", 0] != 0)},
	{},
	[],
	[0, 0, 0],
	10
];

orbis_awesome_ACEInteractions pushBack [1, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome"],
	_actionGPWSmodes,
	true
]];
orbis_awesome_ACEInteractions pushBack [1.1, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbis_gpws_GPWSmodes"],
	_actionTurnOff,
	true
]];

orbis_awesome_ACEInteractions pushBack [1.21, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbis_gpws_GPWSmodes"],
	_actionB747,
	true
]];
orbis_awesome_ACEInteractions pushBack [1.22, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbis_gpws_GPWSmodes"],
	_actionF16,
	true
]];
orbis_awesome_ACEInteractions pushBack [1.23, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbis_gpws_GPWSmodes"],
	_actionRita,
	true
]];

orbis_awesome_ACEInteractions pushBack [1.31, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbis_gpws_GPWSmodes"],
	_testB747,
	true
]];
orbis_awesome_ACEInteractions pushBack [1.32, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbis_gpws_GPWSmodes"],
	_testF16,
	true
]];
orbis_awesome_ACEInteractions pushBack [1.33, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbis_gpws_GPWSmodes"],
	_testRita,
	true
]];
orbis_awesome_ACEInteractions pushBack [1.34, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbis_gpws_GPWSmodes"],
	_testStop,
	true
]];

orbis_awesome_ACEInteractions pushBack [1.41, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbis_gpws_GPWSmodes"],
	_actionVolumeLow,
	true
]];
orbis_awesome_ACEInteractions pushBack [1.42, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbis_gpws_GPWSmodes"],
	_actionVolumeHigh,
	true
]];

orbis_awesome_ACEInteractions pushBack [2, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome"],
	_actionTCASmodes,
	true
]];
orbis_awesome_ACEInteractions pushBack [2.1, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbis_gpws_TCASModes"],
	_actionTCASTARA,
	true
]];
orbis_awesome_ACEInteractions pushBack [2.2, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbis_gpws_TCASModes"],
	_actionTCASTA,
	true
]];
orbis_awesome_ACEInteractions pushBack [2.3, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbis_gpws_TCASModes"],
	_actionTCASSTBY,
	true
]];

orbis_awesome_ACEInteractions pushBack [3, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome"],
	_actionTranspondermodes,
	true
]];
orbis_awesome_ACEInteractions pushBack [3.1, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbis_gpws_TransponderModes"],
	_actionTransponderModeC,
	true
]];
orbis_awesome_ACEInteractions pushBack [3.2, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbis_gpws_TransponderModes"],
	_actionTransponderSTBY,
	true
]];
orbis_awesome_ACEInteractions pushBack [3.3, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbis_gpws_TransponderModes"],
	_actionTransponderOff,
	true
]];
