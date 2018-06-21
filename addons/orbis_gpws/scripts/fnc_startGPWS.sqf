private _vehicle = param [0, vehicle player];
private _mode = param [1, "off"];

if ([nil, nil, 1] call orbis_awesome_main_fnc_isCrew) then {
    switch (_mode) do {
        case ("f16"): {
            _vehicle setVariable ["orbisGPWSmodeLocal", "f16"];
            [_vehicle] spawn orbis_gpws_fnc_f16GPWS;
        };
        case ("b747"): {
            _vehicle setVariable ["orbisGPWSmodeLocal", "b747"];
            [_vehicle] spawn orbis_gpws_fnc_b747GPWS;
        };
        default {
            _vehicle setVariable ["orbisGPWSmodeLocal", "off"];
        };
    };
};
