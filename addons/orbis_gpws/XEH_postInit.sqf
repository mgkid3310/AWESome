player setVariable ["hasOrbisGPWS", true, true];

// global variables init
orbis_gpws_takeoffAlt = 60;
orbis_gpws_airportRange = 6000;

// b747
orbis_gpws_ftToM = 0.3048;
orbis_gpws_pullupLogTime = 8;
orbis_gpws_posExpectTime = 10;
orbis_gpws_terrainWarningHeight = 10;
orbis_gpws_tooLowAlt = 50;
orbis_gpws_maxSinkRate = -40;
orbis_gpws_maxBankAngle = 45;
orbis_gpws_appMinAlt = 350 * orbis_gpws_ftToM;
orbis_gpws_minAlt = 250 * orbis_gpws_ftToM;
orbis_gpws_delay = 2.0;

// f16
orbis_gpws_ChaffFlareList = ["CMFlareLauncher", "FIR_CMLauncher", "js_w_fa18_CMFlareLauncher"];
orbis_gpws_f16PullupTime = 4;
orbis_gpws_f16LowAltitude = 50;
orbis_gpws_f16MaxAOA = 20; // deg
orbis_gpws_f16BingoFuel = 0.2;
orbis_gpws_mslDetectRange = 5000;
orbis_gpws_mslApproachTime = 3;
orbis_gpws_rwrDetectRange = 25000;
orbis_gpws_warningDamageLevel = 0.6;
orbis_gpws_cautionDamageLevel = 0.1;

// rita
orbis_gpws_ritaPullupTime = 4;
orbis_gpws_ritaLowAltitude = 50;
orbis_gpws_ritaMaxAOA = 15;
orbis_gpws_ritaMaxDive = -45;

// get runways list
orbis_gpws_runwayList = [[[0, 0, 0], 0, 8]]; // [[position(ASL), heading, approachAngle], ...]
private _runwayPos = getArray (configFile >> "CfgWorlds" >> worldName >> "ilsPosition");
_runwayPos set [2, getTerrainHeightASL _runwayPos];
private _ilsDirection = getArray (configFile >> "CfgWorlds" >> worldName >> "ilsDirection");
private _dirOpposite = ((asin abs (_ilsDirection select 0)) + 180) % 360;
orbis_gpws_runwayList pushBack [_runwayPos, asin abs (_ilsDirection select 0), asin (_ilsDirection select 1)];
orbis_gpws_runwayList pushBack [_runwayPos getPos [-1000, _dirOpposite], _dirOpposite, 0];

for "_i" from 0 to (count (configFile >> "CfgWorlds" >> worldName >> "SecondaryAirports") - 1) do {
	private _config = (configFile >> "CfgWorlds" >> worldName >> "SecondaryAirports") select _i;
	_runwayPos = getArray (_config >> "ilsPosition");
	_runwayPos set [2, getTerrainHeightASL _runwayPos];
	if (isClass _config) then {
		_ilsDirection = getArray (_config >> "ilsDirection");
		_dirOpposite = ((asin abs (_ilsDirection select 0)) + 180) % 360;
		orbis_gpws_runwayList pushBack [_runwayPos, asin abs (_ilsDirection select 0), asin (_ilsDirection select 1)];
		orbis_gpws_runwayList pushBack [_runwayPos getPos [-1000, _dirOpposite], _dirOpposite, 0];
	};
};
{
	_ilsDirection = getArray (configFile >> "CfgVehicles" >> (typeOf _x) >> "ilsDirection");
	orbis_gpws_runwayList pushBack [getPosASL _x, asin abs (_ilsDirection select 0), asin (_ilsDirection select 1)];
	if !(getNumber (configFile >> "CfgVehicles" >> (typeOf _x) >> "isCarrier") > 0) then {
		_dirOpposite = ((asin abs (_ilsDirection select 0)) + 180) % 360;
		orbis_gpws_runwayList pushBack [(getPosASL _x) getPos [-1000, _dirOpposite], _dirOpposite, 0];
	};
} forEach (allAirports select 1);

// add addon settings
private _defaultMode = profileNamespace getVariable ["orbis_gpws_personallDefault", "none"];
private _defaultVolumeLow = profileNamespace getVariable ["orbis_gpws_defaultVolumeLow", false];
missionNamespace setVariable ["orbis_gpws_personallDefault", _defaultMode];
missionNamespace setVariable ["orbis_gpws_defaultVolumeLow", _defaultVolumeLow];

[
	"orbis_gpws_personallDefault",
	"LIST",
	["Default GPWS Mode", "Activates default GPWS when boarding planes with GPWS turned off"],
	"AWESome GPWS",
	[["none", "b747", "f16", "rita"], ["No default setting", "B747", "Betty (F-16)", "Rita"], ["none", "b747", "f16", "rita"] find _defaultMode],
	nil,
	{
		missionNamespace setVariable ["orbis_gpws_personallDefault", _this];
		profileNamespace setVariable ["orbis_gpws_personallDefault", _this];
	}
] call CBA_Settings_fnc_init;

[
	"orbis_gpws_defaultVolumeLow",
	"LIST",
	["Default GPWS Mode", "Activates default GPWS when boarding planes with GPWS turned off"],
	"AWESome GPWS",
	[[false, true], ["High", "Low"], [0, 1] select _defaultVolumeLow],
	nil,
	{
		missionNamespace setVariable ["orbis_gpws_defaultVolumeLow", _this];
		profileNamespace setVariable ["orbis_gpws_defaultVolumeLow", _this];
	}
] call CBA_Settings_fnc_init;

// add actions (ACE / vanilla)
if (orbis_awesome_hasACEInteractMenu) then {
	[] call orbis_gpws_fnc_addACEInteractMenu;
} else {
	player addEventHandler ["GetInMan", {_this call orbis_gpws_fnc_getInAddAction}];

	if !(vehicle player isEqualTo player) then {
		[player, "", vehicle player, []] call orbis_gpws_fnc_getInAddAction;
	};
};

// add eventhandler
if !(vehicle player isEqualTo player) then {
	[player, getPos player, vehicle player, nil] spawn orbis_gpws_fnc_getInMan;
};
player addEventHandler ["GetInMan", {_this spawn orbis_gpws_fnc_getInMan}];

[] spawn orbis_gpws_fnc_periodicCheck;
