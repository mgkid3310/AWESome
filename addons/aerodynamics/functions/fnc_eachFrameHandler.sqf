#include "script_component.hpp"

private _vehicle = vehicle player;
private _timeOld = missionNamespace getVariable [QGVAR(timeOld), -1];
private _frameOld = missionNamespace getVariable [QGVAR(frameOld), -1];

if (!GVAR(enabled) || (_vehicle isEqualTo player) || (_timeOld < 0) || (_frameOld < 0)) exitWith {
	missionNamespace setVariable [QGVAR(timeOld), time];
	missionNamespace setVariable [QGVAR(frameOld), diag_frameNo];

	private _aeroConfigs = _vehicle getVariable [QGVAR(aeroConfig), false];
	if !(_aeroConfigs isEqualType []) then {
		_aeroConfigs = [_vehicle] call FUNC(getAeroConfig);
		_vehicle setVariable [QGVAR(aeroConfig), _aeroConfigs];
	};
	_vehicle setMass (_aeroConfigs select 3 select 1);
};
if (diag_frameNo < (_frameOld + GVAR(frameInterval))) exitWith {};

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
