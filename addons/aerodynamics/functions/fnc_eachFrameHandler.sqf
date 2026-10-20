#include "script_component.hpp"

private _vehicle = vehicle player;
private _timeOld = missionNamespace getVariable [QGVAR(timeOld), -1];
private _frameOld = missionNamespace getVariable [QGVAR(frameOld), -1];

if ((_timeOld < 0) || (_frameOld < 0)) exitWith {
	missionNamespace setVariable [QGVAR(timeOld), time];
	missionNamespace setVariable [QGVAR(frameOld), diag_frameNo];
};

if (diag_frameNo < (_frameOld + GVAR(frameInterval))) exitWith {};

// restore mass of the plane no longer flown by player
private _isFlying = GVAR(enabled) && {driver _vehicle isEqualTo player} && {(toLower getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "simulation")) in ["airplanex", "planex"]};
private _vehicleFlown = [objNull, _vehicle] select _isFlying;
private _vehicleOld = missionNamespace getVariable [QGVAR(lastVehicle), objNull];
if !(_vehicleOld isEqualTo _vehicleFlown) then {
	if !(isNull _vehicleOld) then {
		private _aeroConfigs = _vehicleOld getVariable [QGVAR(aeroConfig), false];
		if (_aeroConfigs isEqualType []) then {
			if (local _vehicleOld) then {
				_vehicleOld setMass (_aeroConfigs select 3 select 1);
			} else {
				[_vehicleOld, _aeroConfigs select 3 select 1] remoteExec ["setMass", _vehicleOld];
			};
		};
		_vehicleOld setVariable [QGVAR(fWingData), nil];
	};
	missionNamespace setVariable [QGVAR(lastVehicle), _vehicleFlown];
};

if (_vehicle isEqualTo player) exitWith {
	missionNamespace setVariable [QGVAR(timeOld), time];
	missionNamespace setVariable [QGVAR(frameOld), diag_frameNo];
};

if !(GVAR(enabled)) exitWith {
	missionNamespace setVariable [QGVAR(timeOld), time];
	missionNamespace setVariable [QGVAR(frameOld), diag_frameNo];
};

[GVAR(dynamicWindMode)] call FUNC(simulateDynamicWind);

if (driver _vehicle isEqualTo player) then {
	private _simulation = toLower getText (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "simulation");

	// fixed wing
	if (_simulation in ["airplanex", "planex"]) then {
		missionNamespace setVariable [QGVAR(isActive), true];
		[_vehicle, _timeOld] call FUNC(fixedWingLoop);
	} else {
		missionNamespace setVariable [QGVAR(isActive), false];
		if ((_vehicle getVariable [QGVAR(fWingData), false]) isEqualType []) then {
			_vehicle setVariable [QGVAR(fWingData), nil];
		};
	};

	// rotary wing
	/* if (_simulation in [""]) then {
		missionNamespace setVariable [QGVAR(isActive), true];
		[_vehicle, _timeOld] call FUNC(rotaryWingLoop);
	} else {
		missionNamespace setVariable [QGVAR(isActive), false];
		if ((_vehicle getVariable [QGVAR(rWingData), false]) isEqualType []) then {
			_vehicle setVariable [QGVAR(rWingData), nil];
		};
	}; */
};

missionNamespace setVariable [QGVAR(timeOld), time];
missionNamespace setVariable [QGVAR(frameOld), diag_frameNo];
