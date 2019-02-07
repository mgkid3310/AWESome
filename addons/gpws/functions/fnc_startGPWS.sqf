private _vehicle = param [0, vehicle player];
private _mode = param [1, "off"];

if ([nil, nil, 1] call awesome_awesome_fnc_isCrew) then {
    switch (_mode) do {
        case ("b747"): {
            _vehicle setVariable ["orbisGPWSmodeLocal", "b747"];
            [_vehicle] spawn awesome_gpws_fnc_b747GPWS;
        };
        case ("f16"): {
            _vehicle setVariable ["orbisGPWSmodeLocal", "f16"];
            [_vehicle] spawn awesome_gpws_fnc_f16GPWS;
        };
        case ("rita"): {
            _vehicle setVariable ["orbisGPWSmodeLocal", "rita"];
            [_vehicle] spawn awesome_gpws_fnc_ritaGPWS;
        };
        default {
            _vehicle setVariable ["orbisGPWSmodeLocal", "off"];
        };
    };
};
