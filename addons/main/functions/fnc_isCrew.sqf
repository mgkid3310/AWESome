#include "script_component.hpp"

private _player = param [0, player];
private _vehicle = param [1, vehicle _player];
private _mode = param [2, 0]; // 0: both, 1: plane, 2: heli

if !(_player in _vehicle) exitWith {false};
switch (_mode) do {
	case (0): {
		if !((_vehicle isKindOf "Plane") || (_vehicle isKindOf "Helicopter")) exitWith {false};
	};
	case (1): {
		if !(_vehicle isKindOf "Plane") exitWith {false};
	};
	case (2): {
		if !(_vehicle isKindOf "Helicopter") exitWith {false};
	};
};

private _role = [];
if (_player getVariable [QGVAR(hasAWESomeMain), false]) then {
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
