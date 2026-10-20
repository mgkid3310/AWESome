#include "script_component.hpp"

missionNamespace setVariable [QGVAR(hasAWESomeGPWS_) + getPlayerUID player, true, true];

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
GVAR(b747Delay) = 2.0;

// f16
GVAR(ChaffFlareList) = ["CMFlareLauncher", "CMFlareLauncher_Singles", "CMFlareLauncher_Triples", "FIR_CMLauncher", "js_w_fa18_CMFlareLauncher", "js_w_fa18_CMChaffLauncher"];
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
GVAR(runwayList) = []; // [[position(ASL), heading, approachAngle], ...]
private _fnc_addRunway = {
	params ["_runwayPos", "_ilsDirection", ["_dirOffset", 0], ["_hasOpposite", true]];
	_ilsDirection params ["_dirX", "_dirZ", "_dirY"];

	private _heading = ((_dirX atan2 _dirY) + 180 + _dirOffset) % 360;
	GVAR(runwayList) pushBack [_runwayPos, _heading, asin _dirZ];

	if (_hasOpposite) then {
		private _dirOpposite = (_heading + 180) % 360;
		private _posOpposite = _runwayPos getPos [-1000, _dirOpposite];
		_posOpposite set [2, getTerrainHeightASL _posOpposite];
		GVAR(runwayList) pushBack [_posOpposite, _dirOpposite, 0];
	};
};

private _worldConfig = configFile >> "CfgWorlds" >> worldName;
if ((isArray (_worldConfig >> "ilsPosition")) && (isArray (_worldConfig >> "ilsDirection"))) then {
	private _runwayPos = getArray (_worldConfig >> "ilsPosition");
	_runwayPos set [2, getTerrainHeightASL _runwayPos];
	[_runwayPos, getArray (_worldConfig >> "ilsDirection")] call _fnc_addRunway;
};

private _secondaryAirports = _worldConfig >> "SecondaryAirports";
for "_i" from 0 to (count _secondaryAirports - 1) do {
	private _config = _secondaryAirports select _i;
	if ((isClass _config) && {isArray (_config >> "ilsPosition")} && {isArray (_config >> "ilsDirection")}) then {
		private _runwayPos = getArray (_config >> "ilsPosition");
		_runwayPos set [2, getTerrainHeightASL _runwayPos];
		[_runwayPos, getArray (_config >> "ilsDirection")] call _fnc_addRunway;
	};
};

{
	private _config = configFile >> "CfgVehicles" >> (typeOf _x);
	if (isArray (_config >> "ilsDirection")) then {
		[getPosASL _x, getArray (_config >> "ilsDirection"), getDir _x, !(getNumber (_config >> "isCarrier") > 0)] call _fnc_addRunway;
	};
} forEach (allAirports select 1);

// add EventHandlers
if (hasInterface) then {
	["CAManBase", "GetInMan", {
		if ((_this select 0) isEqualTo player) then {_this call FUNC(getInMan)};
	}] call CBA_fnc_addClassEventHandler;

	["CAManBase", "SeatSwitchedMan", {
		params ["_unit1", "_unit2", "_vehicle"];
		if (player in [_unit1, _unit2]) then {[player, "", _vehicle, []] call FUNC(getInMan)};
	}] call CBA_fnc_addClassEventHandler;

	[{!isNull player}, {
		if !(vehicle player isEqualTo player) then {
			[player, "", vehicle player, []] call FUNC(getInMan);
		};
	}] call CBA_fnc_waitUntilAndExecute;
};
addMissionEventHandler ["EachFrame", {[] call FUNC(eachFrameHandler)}];

["Plane", "Init", {_this call FUNC(vehicleInit)}, true, [], true] call CBA_fnc_addClassEventHandler;

// add actions (vanilla)
if (hasInterface && !EGVAR(main,hasACEInteractMenu)) then {
	["CAManBase", "GetInMan", {
		if ((_this select 0) isEqualTo player) then {_this call FUNC(getInAddAction)};
	}] call CBA_fnc_addClassEventHandler;

	[{!isNull player}, {
		if !(vehicle player isEqualTo player) then {
			[player, "", vehicle player, []] call FUNC(getInAddAction);
		};
	}] call CBA_fnc_waitUntilAndExecute;
};
