// global variables init
orbis_gpws_ChaffFlareList = ["js_w_fa18_CMFlareLauncher", "FIR_CMLauncher"];
orbis_gpws_takeoffAlt = 60;
orbis_gpws_airportRange = 6000;
orbis_gpws_pullupTime = 4;
orbis_gpws_lowSpeed = 180;
orbis_gpws_maxAOA = 15;
orbis_gpws_lowAltitude = 50;
orbis_gpws_bingoFuel = 0.2;
orbis_gpsw_mslDetectRange = 5000;
orbis_gpsw_mslApproachTime = 3;
orbis_gpsw_rwrDetectRange = 25000;

// get runways list
orbis_gpws_runwayList = [[[0, 0, 0], 0]]; // [[position(ASL), heading], ...]
private _runwayPos = getArray (configFile >> "CfgWorlds" >> worldName >> "ilsPosition");
_runwayPos set [2, getTerrainHeightASL _runwayPos];
orbis_gpws_runwayList pushBack [_runwayPos, asin abs (getArray (configFile >> "CfgWorlds" >> worldName >> "ilsDirection") select 0)];
orbis_gpws_runwayList pushBack [_runwayPos, asin abs (getArray (configFile >> "CfgWorlds" >> worldName >> "ilsDirection") select 0) call orbis_gpws_fnc_getOppositeHeading];
for "_i" from 0 to (count (configFile >> "CfgWorlds" >> worldName >> "SecondaryAirports") - 1) do {
	private _config = (configFile >> "CfgWorlds" >> worldName >> "SecondaryAirports") select _i;
	_runwayPos = getArray (_config >> "ilsPosition");
	_runwayPos set [2, getTerrainHeightASL _runwayPos];
	if (isClass _config) then {
		orbis_gpws_runwayList pushBack [_runwayPos, asin abs (getArray (_config >> "ilsDirection") select 0)];
		orbis_gpws_runwayList pushBack [_runwayPos, asin abs (getArray (_config >> "ilsDirection") select 0) call orbis_gpws_fnc_getOppositeHeading];
	};
};
{
	orbis_gpws_runwayList pushBack [getPosASL _x, asin abs (getArray (configFile >> "CfgVehicles" >> (typeOf _x) >> "ilsDirection") select 0)];
	if (getNumber (configFile >> "CfgVehicles" >> (typeOf _x) >> isCarrier) isEqualTo 0) then {
		orbis_gpws_runwayList pushBack [getPosASL _x, asin abs (getArray (configFile >> "CfgVehicles" >> (typeOf _x) >> "ilsDirection") select 0) call orbis_gpws_fnc_getOppositeHeading];
	};
} forEach (allAirports select 1);

// add eventhandler
player addEventHandler ["GetInMan", {_this spawn orbis_gpws_fnc_getIn}];
