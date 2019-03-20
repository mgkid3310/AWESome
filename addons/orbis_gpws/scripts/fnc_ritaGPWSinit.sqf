private _vehicle = _this select 0;

_vehicle setVariable ["orbisGPWSready", false];
_vehicle setVariable ["orbisGPWSreadyBeep", true];
[_vehicle, "rita_online"] spawn orbis_gpws_fnc_speakGPWS;
