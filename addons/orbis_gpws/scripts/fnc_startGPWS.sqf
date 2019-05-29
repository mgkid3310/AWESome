private _vehicle = param [0, vehicle player];
private _mode = param [1, "off"];

switch (_mode) do {
	case ("b747"): {
		_vehicle setVariable ["orbisGPWSmodeLocal", "b747"];
		[_vehicle] call orbis_gpws_fnc_b747GPWSinit;
	};
	case ("f16"): {
		_vehicle setVariable ["orbisGPWSmodeLocal", "f16"];
		[_vehicle] call orbis_gpws_fnc_f16GPWSinit;
	};
	case ("rita"): {
		_vehicle setVariable ["orbisGPWSmodeLocal", "rita"];
		[_vehicle] call orbis_gpws_fnc_ritaGPWSinit;
	};
	default {};
};
