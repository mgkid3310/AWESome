#include "script_component.hpp"

params ["_vehicle", "_ammo", "_launcher"];

private _missile = nearestObject [_launcher, _ammo];
private _incomingMSLlist = _vehicle getVariable [QGVAR(incomingMSLlist), []];
_incomingMSLlist = _incomingMSLlist select {alive (_x select 0)};
_incomingMSLlist pushBack [_missile, _ammo, _launcher];
_vehicle setVariable [QGVAR(incomingMSLlist), _incomingMSLlist];
