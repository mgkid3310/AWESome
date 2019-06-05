#include "script_component.hpp"

params ["_vehicle", "_ammo", "_launcher"];

private _missile = nearestObject [_launcher, _ammo];
private _listOld = _vehicle getVariable [QGVAR(incomingMSLlist), []];
_listOld pushBack [_missile, _ammo, _launcher];
_vehicle setVariable [QGVAR(incomingMSLlist), _listOld];
