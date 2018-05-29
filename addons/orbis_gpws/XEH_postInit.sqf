// global variables init
orbis_gpws_takeoffAlt = 60;
orbis_gpws_airportRange = 6000;
orbis_gpws_pullupTime = 4;

// f16
orbis_gpws_ChaffFlareList = ["CMFlareLauncher", "FIR_CMLauncher", "js_w_fa18_CMFlareLauncher"];
orbis_gpws_maxAOA = 15;
orbis_gpws_lowAltitude = 50;
orbis_gpws_bingoFuel = 0.2;
orbis_gpws_mslDetectRange = 5000;
orbis_gpws_mslApproachTime = 3;
orbis_gpws_rwrDetectRange = 25000;
orbis_gpws_warningDamageLevel = 0.6;
orbis_gpws_cautionDamageLevel = 0.1;

// b747
orbis_gpws_ftToM = 0.3048;
orbis_gpws_tooLowAlt = 50;
orbis_gpws_appMinAlt = 350 * orbis_gpws_ftToM;
orbis_gpws_minAlt = 250 * orbis_gpws_ftToM;
orbis_gpws_maxSinkeRate = -40;
orbis_gpws_maxBankAngle = 45;
orbis_gpws_delay = 2.0;

// get runways list
orbis_gpws_runwayList = [[[0, 0, 0], 0]]; // [[position(ASL), heading], ...]
private _runwayPos = getArray (configFile >> "CfgWorlds" >> worldName >> "ilsPosition");
_runwayPos set [2, getTerrainHeightASL _runwayPos];
private _ilsDirection = getArray (configFile >> "CfgWorlds" >> worldName >> "ilsDirection");
orbis_gpws_runwayList pushBack [_runwayPos, asin abs (_ilsDirection select 0), asin (_ilsDirection select 1)];
orbis_gpws_runwayList pushBack [_runwayPos, asin abs (_ilsDirection select 0) call orbis_gpws_fnc_getOppositeHeading, asin (_ilsDirection select 1)];
for "_i" from 0 to (count (configFile >> "CfgWorlds" >> worldName >> "SecondaryAirports") - 1) do {
	private _config = (configFile >> "CfgWorlds" >> worldName >> "SecondaryAirports") select _i;
	_runwayPos = getArray (_config >> "ilsPosition");
	_runwayPos set [2, getTerrainHeightASL _runwayPos];
	if (isClass _config) then {
		_ilsDirection = getArray (_config >> "ilsDirection");
		orbis_gpws_runwayList pushBack [_runwayPos, asin abs (_ilsDirection select 0), asin (_ilsDirection select 1)];
		orbis_gpws_runwayList pushBack [_runwayPos, asin abs (_ilsDirection select 0) call orbis_gpws_fnc_getOppositeHeading, asin (_ilsDirection select 1)];
	};
};
{
	_ilsDirection = getArray (configFile >> "CfgVehicles" >> (typeOf _x) >> "ilsDirection");
	orbis_gpws_runwayList pushBack [getPosASL _x, asin abs (_ilsDirection select 0), asin (_ilsDirection select 1)];
	if (getNumber (configFile >> "CfgVehicles" >> (typeOf _x) >> isCarrier) isEqualTo 0) then {
		orbis_gpws_runwayList pushBack [getPosASL _x, asin abs (_ilsDirection select 0) call orbis_gpws_fnc_getOppositeHeading, asin (_ilsDirection select 1)];
	};
} forEach (allAirports select 1);

if (orbis_awesome_hasACEInteractMenu) then {
    [] call orbis_gpws_fnc_addACEInteractMenu;
} else {
    player addEventHandler ["GetInMan", {_this call orbis_gpws_fnc_getInAddAction}];

    if !(vehicle player isEqualTo player) then {
    	[player, "", vehicle player, []] call orbis_gpws_fnc_getInAddAction;
    };
};

// add global event
["orbisStartGPWS", {
	private _vehicle = _this select 0;
	private _mode = _this select 1;

	if (local _vehicle) then {
		switch (_mode) do {
		    case ("f16"): {
		        //code
		    };
		    case ("b747"): {
		        //code
		    };
			default {};
		};
	};
}] call CBA_fnc_addEventHandler;

["orbisPlaySoundGPWS", {
	private _vehicle = _this select 0;
	private _sound = _this select 1;

	if (player in [driver _vehicle, gunner _vehicle, commander _vehicle]) then {
		playSound _sound;
	};
}] call CBA_fnc_addEventHandler;

// add eventhandler
if (vehicle player != player) then {
	[player, getPos player, vehicle player, nil] spawn orbis_gpws_fnc_getInMan;
};
player addEventHandler ["GetInMan", {_this spawn orbis_gpws_fnc_getInMan}];
