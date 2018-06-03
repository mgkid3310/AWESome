private ["_vehicle", "_mode", "_caller"];

while {true} do {
    _vehicle = vehicle player;
    if (_vehicle isKindOf "Plane") then {
        _modePublic = _vehicle getVariable ["orbisGPWSmode", ""];
        _modeLocal = _vehicle getVariable ["orbisGPWSmodeLocal", ""];
        _caller = _vehicle getVariable ["orbisGPWScaller", player];

        if (_modePublic != _modeLocal) then {
            _vehicle setVariable ["orbisGPWSmodeLocal", _modePublic];
            [_vehicle, _modePublic] spawn orbis_gpws_fnc_startGPWS;
        };
    };

    private _frameNo = diag_frameNo + 3;
    waitUntil {diag_frameNo > _frameNo};
};
