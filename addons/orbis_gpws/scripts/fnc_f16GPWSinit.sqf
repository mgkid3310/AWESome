private _vehicle = _this select 0;

private _chaffFlare = _vehicle addEventHandler ["Fired", {_this spawn orbis_gpws_fnc_f16ChaffFlare}]; // f16_chaffFlare, f16_chaffFlareLow, f16_chaffFlareOut
private _incomingMSL = _vehicle addEventHandler ["IncomingMissile", {_this spawn orbis_gpws_fnc_incomingMSL}]; // stack list of incoming MSLs

_vehicle setVariable ["orbisGPWSready", true];
_vehicle setVariable ["orbisGPWSreadyBeep", true];
_vehicle setVariable ["gpwsEventHandlers", [_chaffFlare, _incomingMSL]];
