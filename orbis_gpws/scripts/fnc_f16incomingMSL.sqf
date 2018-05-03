params ["_vehicle", "_ammo", "_launcher"];

private _missile = nearestObject [_launcher, _ammo];
private _listOld = _vehicle getVariable ["incomingMSLlist", []];
_listOld pushBack [_missile, _ammo, _launcher];
_vehicle setVariable ["incomingMSLlist", _listOld];
