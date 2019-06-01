params ["_vehicle", "_ammo", "_launcher"];

private _missile = nearestObject [_launcher, _ammo];
private _listOld = _vehicle getVariable ["orbis_gpws_incomingMSLlist", []];
_listOld pushBack [_missile, _ammo, _launcher];
_vehicle setVariable ["orbis_gpws_incomingMSLlist", _listOld];
