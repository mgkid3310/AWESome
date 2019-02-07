private ["_vehicle", "_mode", "_caller"];

while {true} do {
    _vehicle = vehicle player;
    if (_vehicle isKindOf "Plane") then {
        _modePublic = "off";
        if (isEngineOn _vehicle) then {
            _modePublic = _vehicle getVariable ["orbisGPWSmode", "off"];
        };
        _modeLocal = _vehicle getVariable ["orbisGPWSmodeLocal", "off"];

        if (_modePublic != _modeLocal) then {
            _vehicle setVariable ["orbisGPWSmodeLocal", _modePublic];
            [_vehicle, _modePublic] spawn awesome_gpws_fnc_startGPWS;
        };
    };

    private _frameNo = diag_frameNo;
    waitUntil {diag_frameNo > _frameNo};
};
