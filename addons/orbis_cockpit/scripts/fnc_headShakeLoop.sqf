params ["_vehicle", "_player", "_timeOld"];

if !(missionNamespace getVariable ["orbis_cockpit_shakeEnabled", true]) exitWith {};

private _timeStep = time - _timeOld;
if !(_timeStep > 0) exitWith {};

private _groundOld = _vehicle getVariable ["orbis_cockpit_groundOld", 0];
if !(_groundOld isEqualType true) exitWith {
    _vehicle setVariable ["orbis_cockpit_groundOld", isTouchingGround _vehicle];
};
private _intensity = 0;

private _speedFactor = 0;
private _velocity = velocityModelSpace _vehicle;
private _speed = (3.6 * vectorMagnitude _velocity) min orbis_cockpit_speedMaxShake;
private _onGround = isTouchingGround _vehicle;

if (_onGround) then {
	_speedFactor = _speed * orbis_cockpit_groundShake * (missionNamespace getVariable ["orbis_cockpit_groundMultiplier", 1]);
} else {
	_speedFactor = _speed * orbis_cockpit_speedShake * (missionNamespace getVariable ["orbis_cockpit_speedMultiplier", 1]);
};

private _touchdownFactor = 0;
if (!_groundOld && _onGround) then {
    _touchdownFactor = abs (velocity _vehicle select 2) * orbis_cockpit_touchdownShake * (missionNamespace getVariable ["orbis_cockpit_groundMultiplier", 1]);
};

_intensity = _speedFactor + _touchdownFactor;

enableCamShake true;
setCamShakeParams [0.01, 0.4, 0.4, 0.4, true];
addCamShake [_intensity, 2, 50];

_vehicle setVariable ["orbis_cockpit_velOld", _velocity];
_vehicle setVariable ["orbis_cockpit_groundOld", _onGround];
