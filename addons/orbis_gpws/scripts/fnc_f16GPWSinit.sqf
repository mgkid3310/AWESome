private _vehicle = _this select 0;

private _chaffFlare = _vehicle addEventHandler ["Fired", {_this spawn orbis_gpws_fnc_f16ChaffFlare}]; // f16_chaffFlare, f16_chaffFlareLow, f16_chaffFlareOut
private _incomingMSL = _vehicle addEventHandler ["IncomingMissile", {_this spawn orbis_gpws_fnc_incomingMSL}]; // stack list of incoming MSLs

_vehicle setVariable ["orbis_gpws_GPWSready", true];
_vehicle setVariable ["orbis_gpws_GPWSreadyBeep", true];
_vehicle setVariable ["orbis_gpws_GPWSeventHandlers", [_chaffFlare, _incomingMSL]];
