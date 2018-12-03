params ["_vehicle", "_player", "_timeOld"];

private _timeStep = time - _timeOld;
if !(_timeStep > 0) exitWith {};

private _groundOld = _vehicle getVariable ["orbis_cockpit_groundOld", 0];
if !(_groundOld isEqualType true) exitWith {
    _vehicle setVariable ["orbis_cockpit_groundOld", isTouchingGround _vehicle];
};
private _intensity = 0;

private _speedFactor = 0;
private _velocity = velocityModelSpace _vehicle;
private _speed = vectorMagnitude _velocity;
_speedFactor = _speed * orbis_cockpit_speedMultiplier;

private _onGround = isTouchingGround _vehicle;
private _groundMultiplier = [1, orbis_cockpit_groundMultiplier] select _onGround;
_speedFactor = _speedFactor * _groundMultiplier;

private _touchdownFactor = 0;
if (!_groundOld && _onGround) then {
    private _vertical = velocity _vehicle select 2;
    _touchdownFactor = abs _vertical * orbis_cockpit_touchdownMultiplier;
};

_intensity = _speedFactor + _touchdownFactor;

enableCamShake true;
setCamShakeParams [0.01, 0.4, 0.4, 0.4, true];
addCamShake [_intensity, 3, 50];

_vehicle setVariable ["orbis_cockpit_velOld", _velocity];
_vehicle setVariable ["orbis_cockpit_groundOld", _onGround];
