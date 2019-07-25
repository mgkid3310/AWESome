#include "script_component.hpp"

params ["_throttle", "_input", "_timeStep"];

if (_throttle isEqualTo _input) exitWith {_throttle};

if (_input > _throttle) then {
	_throttle = _input min (_throttle + GVAR(throttleClimbRate) * _timeStep);
} else {
	_throttle = _input max (_throttle - GVAR(throttleDropRate) * _timeStep);
};

_throttle
