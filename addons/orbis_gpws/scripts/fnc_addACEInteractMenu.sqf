// GPWS parent action
private _actionGPWSmodes = [
	"orbisGPWSmodes",
	"GPWS",
	"",
	{},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && (_target getVariable ["orbisGPWSenabled", false])},
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
	{_target setVariable ["orbisGPWSmode", "off", true]},
	{(_target getVariable ["orbisGPWSmodeLocal", "off"] != "off")},
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
	{_target setVariable ["orbisGPWSmode", "b747", true]},
	{(_target getVariable ["orbisGPWSmodeLocal", "off"] != "b747")},
	{},
	[],
	[0, 0, 0],
	10
];
private _actionF16 = [
	"f16",
	"Set to Betty (F-16)",
	"",
	{_target setVariable ["orbisGPWSmode", "f16", true]},
	{(_target getVariable ["orbisGPWSmodeLocal", "off"] != "f16")},
	{},
	[],
	[0, 0, 0],
	10
];
private _actionRita = [
	"rita",
	"Set to Rita",
	"",
	{_target setVariable ["orbisGPWSmode", "rita", true]},
	{(_target getVariable ["orbisGPWSmodeLocal", "off"] != "rita")},
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
	{(_target getVariable ["orbisGPWSmodeLocal", "off"] == "b747") && (_target getVariable ["orbisGPWStestReady", true])},
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
	{(_target getVariable ["orbisGPWSmodeLocal", "off"] == "f16") && (_target getVariable ["orbisGPWStestReady", true])},
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
	{(_target getVariable ["orbisGPWSmodeLocal", "off"] == "rita") && (_target getVariable ["orbisGPWStestReady", true])},
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
	{_target setVariable ["orbisGPWStestStop", true, true]},
	{(_target getVariable ["orbisGPWSmodeLocal", "off"] != "off") && !(_target getVariable ["orbisGPWStestReady", true]) && !(_target getVariable ["orbisGPWStestStop", false])},
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
	{_target setVariable ["orbisGPWSvolumeLow", true, true]},
	{!(_target getVariable ["orbisGPWSvolumeLow", false])},
	{},
	[],
	[0, 0, 0],
	10
];
private _actionVolumeHigh = [
	"volumeHigh",
	"Increase Volume",
	"",
	{_target setVariable ["orbisGPWSvolumeLow", false, true]},
	{(_target getVariable ["orbisGPWSvolumeLow", false])},
	{},
	[],
	[0, 0, 0],
	10
];

// TCAS parent action
private _actionTCASmodes = [
	"orbisTCASmodes",
	"TCAS",
	"",
	{},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && !(_target getVariable ["orbisTCASmode", 0] < 0)},
	{},
	[],
	[0, 0, 0],
	10
];

// TCAS mode C STBY off
private _actionModeC = [
	"tcas_modeC",
	"Mode C",
	"",
	{_target setVariable ["orbisTCASmode", 2, true]},
	{(_target getVariable ["orbisTCASmode", 0] != 2)},
	{},
	[],
	[0, 0, 0],
	10
];
private _actionSTBY = [
	"tcas_stby",
	"Stand By",
	"",
	{_target setVariable ["orbisTCASmode", 1, true]},
	{(_target getVariable ["orbisTCASmode", 0] != 1)},
	{},
	[],
	[0, 0, 0],
	10
];
private _actionOff = [
	"tcas_off",
	"Off",
	"",
	{_target setVariable ["orbisTCASmode", 0, true]},
	{(_target getVariable ["orbisTCASmode", 0] != 0)},
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
	["ACE_SelfActions", "AWESome", "orbisGPWSmodes"],
	_actionTurnOff,
	true
]];

orbis_awesome_ACEInteractions pushBack [1.21, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbisGPWSmodes"],
	_actionB747,
	true
]];
orbis_awesome_ACEInteractions pushBack [1.22, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbisGPWSmodes"],
	_actionF16,
	true
]];
orbis_awesome_ACEInteractions pushBack [1.23, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbisGPWSmodes"],
	_actionRita,
	true
]];

orbis_awesome_ACEInteractions pushBack [1.31, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbisGPWSmodes"],
	_testB747,
	true
]];
orbis_awesome_ACEInteractions pushBack [1.32, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbisGPWSmodes"],
	_testF16,
	true
]];
orbis_awesome_ACEInteractions pushBack [1.33, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbisGPWSmodes"],
	_testRita,
	true
]];
orbis_awesome_ACEInteractions pushBack [1.34, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbisGPWSmodes"],
	_testStop,
	true
]];

orbis_awesome_ACEInteractions pushBack [1.41, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbisGPWSmodes"],
	_actionVolumeLow,
	true
]];
orbis_awesome_ACEInteractions pushBack [1.42, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbisGPWSmodes"],
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
	["ACE_SelfActions", "AWESome", "orbisTCASmodes"],
	_actionModeC,
	true
]];
orbis_awesome_ACEInteractions pushBack [2.2, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbisTCASmodes"],
	_actionSTBY,
	true
]];
orbis_awesome_ACEInteractions pushBack [2.3, [
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbisTCASmodes"],
	_actionOff,
	true
]];
