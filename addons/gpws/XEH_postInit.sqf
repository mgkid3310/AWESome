player setVariable ["hasOrbisGPWS", true, true];

// global variables init
awesome_gpws_takeoffAlt = 60;
awesome_gpws_takeoffSpeed = 500;
awesome_gpws_airportRange = 6000;

// b747
awesome_gpws_pullupLogTime = 8;
awesome_gpws_posExpectTime = 10;
awesome_gpws_terrainWarningHeight = 10;
awesome_gpws_tooLowAlt = 50;
awesome_gpws_maxSinkRate = -40;
awesome_gpws_maxBankAngle = 45;
awesome_gpws_appMinAlt = 350;
awesome_gpws_minAlt = 250;
awesome_gpws_delay = 2.0;

// f16
awesome_gpws_ChaffFlareList = ["CMFlareLauncher", "FIR_CMLauncher", "js_w_fa18_CMFlareLauncher"];
awesome_gpws_f16PullupTime = 4;
awesome_gpws_f16LowAltitude = 50;
awesome_gpws_f16MaxAOA = 20; // deg
awesome_gpws_f16BingoFuel = 0.2;
awesome_gpws_mslDetectRange = 5000;
awesome_gpws_mslApproachTime = 3;
awesome_gpws_rwrDetectRange = 25000;
awesome_gpws_warningDamageLevel = 0.6;
awesome_gpws_cautionDamageLevel = 0.1;

// rita
awesome_gpws_ritaPullupTime = 4;
awesome_gpws_ritaLowAltitude = 50;
awesome_gpws_ritaMaxAOA = 15;
awesome_gpws_ritaMaxDive = -45;

// get runways list
awesome_gpws_runwayList = [[[0, 0, 0], 0, 8]]; // [[position(ASL), heading, approachAngle], ...]
private _runwayPos = getArray (configFile >> "CfgWorlds" >> worldName >> "ilsPosition");
_runwayPos set [2, getTerrainHeightASL _runwayPos];
private _ilsDirection = getArray (configFile >> "CfgWorlds" >> worldName >> "ilsDirection");
private _dirOpposite = ((asin abs (_ilsDirection select 0)) + 180) % 360;
awesome_gpws_runwayList pushBack [_runwayPos, asin abs (_ilsDirection select 0), asin (_ilsDirection select 1)];
awesome_gpws_runwayList pushBack [_runwayPos getPos [-1000, _dirOpposite], _dirOpposite, 0];

for "_i" from 0 to (count (configFile >> "CfgWorlds" >> worldName >> "SecondaryAirports") - 1) do {
	private _config = (configFile >> "CfgWorlds" >> worldName >> "SecondaryAirports") select _i;
	_runwayPos = getArray (_config >> "ilsPosition");
	_runwayPos set [2, getTerrainHeightASL _runwayPos];
	if (isClass _config) then {
		_ilsDirection = getArray (_config >> "ilsDirection");
		_dirOpposite = ((asin abs (_ilsDirection select 0)) + 180) % 360;
		awesome_gpws_runwayList pushBack [_runwayPos, asin abs (_ilsDirection select 0), asin (_ilsDirection select 1)];
		awesome_gpws_runwayList pushBack [_runwayPos getPos [-1000, _dirOpposite], _dirOpposite, 0];
	};
};
{
	_ilsDirection = getArray (configFile >> "CfgVehicles" >> (typeOf _x) >> "ilsDirection");
	awesome_gpws_runwayList pushBack [getPosASL _x, asin abs (_ilsDirection select 0), asin (_ilsDirection select 1)];
	if !(getNumber (configFile >> "CfgVehicles" >> (typeOf _x) >> "isCarrier") > 0) then {
		_dirOpposite = ((asin abs (_ilsDirection select 0)) + 180) % 360;
		awesome_gpws_runwayList pushBack [(getPosASL _x) getPos [-1000, _dirOpposite], _dirOpposite, 0];
	};
} forEach (allAirports select 1);

// add actions (ACE / vanilla)
if (awesome_awesome_hasACEInteractMenu) then {
	[] call awesome_gpws_fnc_addACEInteractMenu;
} else {
	player addEventHandler ["GetInMan", {_this call awesome_gpws_fnc_getInAddAction}];

	if !(vehicle player isEqualTo player) then {
		[player, "", vehicle player, []] call awesome_gpws_fnc_getInAddAction;
	};
};

// add eventhandler
if !(vehicle player isEqualTo player) then {
	[player, getPos player, vehicle player, nil] spawn awesome_gpws_fnc_getInMan;
};
player addEventHandler ["GetInMan", {_this spawn awesome_gpws_fnc_getInMan}];

[] spawn awesome_gpws_fnc_periodicCheck;
