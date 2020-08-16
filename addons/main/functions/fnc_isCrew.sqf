#include "script_component.hpp"

private _player = param [0, player];
private _vehicle = param [1, vehicle _player];
private _mode = param [2, 0]; // -1: pass, 0: plane/heli, 1: plane, 2: heli

if !(_player in crew _vehicle) exitWith {false};

private _typeMatch = false;
switch (_mode) do {
	case (0): {
		_typeMatch = (_vehicle isKindOf "Plane") || (_vehicle isKindOf "Helicopter");
	};
	case (1): {
		_typeMatch = _vehicle isKindOf "Plane";
	};
	case (2): {
		_typeMatch = _vehicle isKindOf "Helicopter";
	};
	default {
		_typeMatch = true;
	};
};
if !(_typeMatch) exitWith {false};

private _role = [];
if (missionNamespace getVariable [QGVAR(hasAWESomeMain_) + getPlayerUID player, false]) then {
	_role = (_player getVariable [QGVAR(crewStatus), []]) select 1;
} else {
	_role = assignedVehicleRole _player;
};

private _return = false;
if (_role isEqualTo []) then {
	_return = _player in [driver _vehicle, gunner _vehicle];
} else {
	switch (toLower (_role select 0)) do {
		case ("driver"): {
			_return = true;
		};
		case ("turret"): {
			_return = (_role select 1) isEqualTo [0];
		};
	};
};

_return
