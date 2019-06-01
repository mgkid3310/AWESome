private _vehicle = _this select 0;

_vehicle setVariable ["orbis_gpws_f16Data", nil];

private _gpwsEventHandlers = _vehicle getVariable ["orbis_gpws_GPWSeventHandlers", [_chaffFlare, _incomingMSL]];
_vehicle removeEventHandler ["Fired", _gpwsEventHandlers select 0];
_vehicle removeEventHandler ["IncomingMissile", _gpwsEventHandlers select 1];
