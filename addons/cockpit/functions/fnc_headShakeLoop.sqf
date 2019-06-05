#include "script_component.hpp"

params ["_vehicle", "_player", "_timeOld"];

if !(GVAR(shakeEnabled)) exitWith {};

private _timeStep = time - _timeOld;
if !(_timeStep > 0) exitWith {};

private _groundOld = _vehicle getVariable [QGVAR(groundOld), 0];
if !(_groundOld isEqualType true) exitWith {
	_vehicle setVariable [QGVAR(groundOld), isTouchingGround _vehicle];
};
private _intensity = 0;

private _speedFactor = 0;
private _velocity = velocityModelSpace _vehicle;
private _speed = (3.6 * vectorMagnitude _velocity) min GVAR(speedMaxShake);
private _onGround = isTouchingGround _vehicle;

if (_onGround) then {
	_speedFactor = _speed * GVAR(groundShake) * GVAR(groundMultiplier);
} else {
	_speedFactor = _speed * GVAR(speedShake) * GVAR(speedMultiplier);
};

private _touchdownFactor = 0;
if (!_groundOld && _onGround) then {
	_touchdownFactor = abs (velocity _vehicle select 2) * GVAR(touchdownShake) * GVAR(groundMultiplier);
};

_intensity = _speedFactor + _touchdownFactor;

enableCamShake true;
setCamShakeParams [0.01, 0.4, 0.4, 0.4, true];
addCamShake [_intensity, 2, 50];

_vehicle setVariable [QGVAR(velOld), _velocity];
_vehicle setVariable [QGVAR(groundOld), _onGround];
