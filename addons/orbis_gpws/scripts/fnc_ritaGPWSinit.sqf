private _vehicle = _this select 0;

_vehicle setVariable ["orbis_gpws_GPWSready", false];
_vehicle setVariable ["orbis_gpws_GPWSreadyBeep", true];
[_vehicle, "rita_online"] spawn orbis_gpws_fnc_speakGPWS;
