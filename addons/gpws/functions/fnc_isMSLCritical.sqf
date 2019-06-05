#include "script_component.hpp"

params ["_vehicle", "_missile"];

private _offset = getPosASL _vehicle vectorDiff getPosASL _missile; // offset from missile to vehicle
private _velocity = velocity _missile vectorDiff velocity _vehicle; // velocity the missile is moving relative to vehicle
private _spdRadial = _velocity vectorDotProduct vectorNormalized _offset; // radial speed of the missile

(vectorMagnitude _offset) < (_spdRadial * GVAR(mslApproachTime))
