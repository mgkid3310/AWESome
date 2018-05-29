private _vehicle = _this select 0;
private _mode = _this select 1;
private _public = param [2, false];
private _caller = param [3, player];

if (player in [driver _vehicle, gunner _vehicle, commander _vehicle]) then {
    switch (_mode) do {
        case ("f16"): {
            _vehicle setVariable ["orbisGPWSmode", _mode, true];
            _vehicle setVariable ["orbisGPWSmodeLocal", _mode];
            _vehicle setVariable ["orbisGPWScaller", _caller, true];
            [_target] spawn orbis_gpws_fnc_f16GPWS;
        };
        case ("b747"): {{
            _vehicle setVariable ["orbisGPWSmode", _mode, true];
            _vehicle setVariable ["orbisGPWSmodeLocal", _mode];
            _vehicle setVariable ["orbisGPWScaller", _caller, true];
            [_target] spawn orbis_gpws_fnc_b747GPWS;
        };
        default {
            _vehicle setVariable ["orbisGPWSmode", "", true];
            _vehicle setVariable ["orbisGPWSmodeLocal", ""];
            _vehicle setVariable ["orbisGPWScaller", objNull, true];
        };
    };
};
