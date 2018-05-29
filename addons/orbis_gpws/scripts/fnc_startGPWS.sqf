private _vehicle = param [0, vehicle player];
private _mode = param [1, ""];
private _public = param [2, false];
private _caller = param [3, player];

if (_caller in [driver _vehicle, gunner _vehicle, commander _vehicle]) then {
    switch (_mode) do {
        case ("f16"): {
            _vehicle setVariable ["orbisGPWSmode", _mode];
            _vehicle setVariable ["orbisGPWSmodeLocal", _mode];
            if (_public) then {
                _vehicle setVariable ["orbisGPWSmode", _mode, true];
                _vehicle setVariable ["orbisGPWScaller", _caller, true];
            };
            [_vehicle] spawn orbis_gpws_fnc_f16GPWS;
        };
        case ("b747"): {
            _vehicle setVariable ["orbisGPWSmode", _mode];
            _vehicle setVariable ["orbisGPWSmodeLocal", _mode];
            if (_public) then {
                _vehicle setVariable ["orbisGPWSmode", _mode, true];
                _vehicle setVariable ["orbisGPWScaller", _caller, true];
            };
            [_vehicle] spawn orbis_gpws_fnc_b747GPWS;
        };
        default {
            _vehicle setVariable ["orbisGPWSmode", ""];
            _vehicle setVariable ["orbisGPWSmodeLocal", ""];
            if (_public) then {
                _vehicle setVariable ["orbisGPWSmode", "", true];
                _vehicle setVariable ["orbisGPWScaller", _caller, true];
            };
        };
    };
};
