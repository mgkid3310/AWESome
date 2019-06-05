#include "script_component.hpp"

private _player = param [0, player];
private _vehicle = param [1, vehicle player];
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

private _role = assignedVehicleRole _player;
private _return = false;
switch (toLower (_role select 0)) do {
	case ("driver"): {
		_return = true;
	};
	case ("turret"): {
		if ((_role select 1) isEqualTo [0]) then {
			_return = true;
		};
	};
};

_return
