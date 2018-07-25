// parent action
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
] call ace_interact_menu_fnc_createAction;

// turn GPWS off
private _actionTurnOff = [
	"turnOff",
	"Turn off GPWS",
	"",
	{_target setVariable ["orbisGPWSmode", "off", true]},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && (_target getVariable ["orbisGPWSenabled", false]) && (_target getVariable ["orbisGPWSmodeLocal", "off"] != "off")},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;

// set mode action
private _actionB747 = [
	"b747",
	"Set to B747 GPWS",
	"",
	{_target setVariable ["orbisGPWSmode", "b747", true]},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && (_target getVariable ["orbisGPWSenabled", false]) && (_target getVariable ["orbisGPWSmodeLocal", "off"] != "b747")},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _actionF16 = [
	"f16",
	"Set to Betty (F-16)",
	"",
	{_target setVariable ["orbisGPWSmode", "f16", true]},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && (_target getVariable ["orbisGPWSenabled", false]) && (_target getVariable ["orbisGPWSmodeLocal", "off"] != "f16")},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _actionRita = [
	"rita",
	"Set to Rita",
	"",
	{_target setVariable ["orbisGPWSmode", "rita", true]},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && (_target getVariable ["orbisGPWSenabled", false]) && (_target getVariable ["orbisGPWSmodeLocal", "off"] != "rita")},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;

// test action
private _testB747 = [
	"f16Test",
	"Test GPWS (B747)",
	"",
	{[_target] spawn orbis_gpws_fnc_b747GPWStest},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && (_target getVariable ["orbisGPWSenabled", false]) && (_target getVariable ["orbisGPWSmodeLocal", "off"] == "b747") && (_target getVariable ["orbisGPWStestReady", true])},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _testF16 = [
	"f16Test",
	"Test GPWS (Betty)",
	"",
	{[_target] spawn orbis_gpws_fnc_f16GPWStest},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && (_target getVariable ["orbisGPWSenabled", false]) && (_target getVariable ["orbisGPWSmodeLocal", "off"] == "f16") && (_target getVariable ["orbisGPWStestReady", true])},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _testRita = [
	"ritaTest",
	"Test GPWS (Rita)",
	"",
	{[_target] spawn orbis_gpws_fnc_ritaGPWStest},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && (_target getVariable ["orbisGPWSenabled", false]) && (_target getVariable ["orbisGPWSmodeLocal", "off"] == "rita") && (_target getVariable ["orbisGPWStestReady", true])},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;

// stop currently running GPWS test
private _testStop = [
	"testStop",
	"Stop GPWS Test",
	"",
	{_target setVariable ["orbisGPWStestStop", true, true]},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && (_target getVariable ["orbisGPWSenabled", false]) && (_target getVariable ["orbisGPWSmodeLocal", "off"] != "off") && !(_target getVariable ["orbisGPWStestReady", true]) && !(_target getVariable ["orbisGPWStestStop", false])},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;

// volume change
private _actionVolumeLow = [
	"volumeLow",
	"Lower Volume",
	"",
	{_target setVariable ["orbisGPWSvolumeLow", true, true]},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && (_target getVariable ["orbisGPWSenabled", false]) && !(_target getVariable ["orbisGPWSvolumeLow", false])},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;
private _actionVolumeHigh = [
	"volumeHigh",
	"Increase Volume",
	"",
	{_target setVariable ["orbisGPWSvolumeLow", false, true]},
	{([nil, nil, 1] call orbis_awesome_fnc_isCrew) && (_target getVariable ["orbisGPWSenabled", false]) && (_target getVariable ["orbisGPWSvolumeLow", false])},
	{},
	[],
	[0, 0, 0],
	10
] call ace_interact_menu_fnc_createAction;

[
	"Plane",
	1,
	["ACE_SelfActions", "AWESome"],
	_actionGPWSmodes,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbisGPWSmodes"],
	_actionTurnOff,
    true
] call ace_interact_menu_fnc_addActionToClass;

[
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbisGPWSmodes"],
	_actionB747,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbisGPWSmodes"],
	_actionF16,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbisGPWSmodes"],
	_actionRita,
    true
] call ace_interact_menu_fnc_addActionToClass;

[
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbisGPWSmodes"],
	_testB747,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbisGPWSmodes"],
	_testF16,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbisGPWSmodes"],
	_testRita,
    true
] call ace_interact_menu_fnc_addActionToClass;

[
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbisGPWSmodes"],
	_testStop,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbisGPWSmodes"],
	_actionVolumeLow,
    true
] call ace_interact_menu_fnc_addActionToClass;
[
	"Plane",
	1,
	["ACE_SelfActions", "AWESome", "orbisGPWSmodes"],
	_actionVolumeHigh,
    true
] call ace_interact_menu_fnc_addActionToClass;
