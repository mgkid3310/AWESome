#include "script_component.hpp"

player setVariable [QGVAR(hasAWESomeGPWS), true, true];

// init global variables
GVAR(takeoffAlt) = 60;
GVAR(takeoffSpeed) = 500;
GVAR(airportRange) = 6000;

// b747
GVAR(pullupLogTime) = 8;
GVAR(posExpectTime) = 10;
GVAR(terrainWarningHeight) = 10;
GVAR(tooLowAlt) = 50;
GVAR(maxSinkRate) = -40;
GVAR(maxBankAngle) = 45;
GVAR(appMinAlt) = 350;
GVAR(minAlt) = 250;
GVAR(delay) = 2.0;

// f16
GVAR(ChaffFlareList) = ["CMFlareLauncher", "FIR_CMLauncher", "js_w_fa18_CMFlareLauncher", "js_w_fa18_CMChaffLauncher"];
GVAR(f16PullupTime) = 4;
GVAR(f16LowAltitude) = 50;
GVAR(f16MaxAOA) = 20; // deg
GVAR(f16BingoFuel) = 0.2;
GVAR(mslDetectRange) = 5000;
GVAR(mslApproachTime) = 3;
GVAR(rwrDetectRange) = 25000;
GVAR(warningDamageLevel) = 0.6;
GVAR(cautionDamageLevel) = 0.1;

// rita
GVAR(ritaPullupTime) = 4;
GVAR(ritaLowAltitude) = 50;
GVAR(ritaMaxAOA) = 15;
GVAR(ritaMaxDive) = -45;

// get runways list
GVAR(runwayList) = [[[0, 0, 0], 0, 8]]; // [[position(ASL), heading, approachAngle], ...]
private _runwayPos = getArray (configFile >> "CfgWorlds" >> worldName >> "ilsPosition");
_runwayPos set [2, getTerrainHeightASL _runwayPos];
private _ilsDirection = getArray (configFile >> "CfgWorlds" >> worldName >> "ilsDirection");
private _dirOpposite = ((asin abs (_ilsDirection select 0)) + 180) % 360;
GVAR(runwayList) pushBack [_runwayPos, asin abs (_ilsDirection select 0), asin (_ilsDirection select 1)];
GVAR(runwayList) pushBack [_runwayPos getPos [-1000, _dirOpposite], _dirOpposite, 0];

for "_i" from 0 to (count (configFile >> "CfgWorlds" >> worldName >> "SecondaryAirports") - 1) do {
	private _config = (configFile >> "CfgWorlds" >> worldName >> "SecondaryAirports") select _i;
	_runwayPos = getArray (_config >> "ilsPosition");
	_runwayPos set [2, getTerrainHeightASL _runwayPos];
	if (isClass _config) then {
		_ilsDirection = getArray (_config >> "ilsDirection");
		_dirOpposite = ((asin abs (_ilsDirection select 0)) + 180) % 360;
		GVAR(runwayList) pushBack [_runwayPos, asin abs (_ilsDirection select 0), asin (_ilsDirection select 1)];
		GVAR(runwayList) pushBack [_runwayPos getPos [-1000, _dirOpposite], _dirOpposite, 0];
	};
};
{
	_ilsDirection = getArray (configFile >> "CfgVehicles" >> (typeOf _x) >> "ilsDirection");
	GVAR(runwayList) pushBack [getPosASL _x, asin abs (_ilsDirection select 0), asin (_ilsDirection select 1)];
	if !(getNumber (configFile >> "CfgVehicles" >> (typeOf _x) >> "isCarrier") > 0) then {
		_dirOpposite = ((asin abs (_ilsDirection select 0)) + 180) % 360;
		GVAR(runwayList) pushBack [(getPosASL _x) getPos [-1000, _dirOpposite], _dirOpposite, 0];
	};
} forEach (allAirports select 1);

// add EventHandlers
if !(vehicle player isEqualTo player) then {
	[player, getPos player, vehicle player, nil] spawn FUNC(getInMan);
};
player addEventHandler ["GetInMan", {_this spawn FUNC(getInMan)}];
addMissionEventHandler ["EachFrame", {[] call FUNC(eachFrameHandler)}];

["Plane", "Init", {_this call FUNC(vehicleInit)}, true, [], true] call CBA_fnc_addClassEventHandler;
