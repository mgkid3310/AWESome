private _vehicle = param [0, vehicle player];
private _mode = param [1, "off"];

switch (_mode) do {
	case ("b747"): {
		_vehicle setVariable ["orbis_gpws_GPWSmodeLocal", "b747"];
		[_vehicle] call orbis_gpws_fnc_b747GPWSinit;
	};
	case ("f16"): {
		_vehicle setVariable ["orbis_gpws_GPWSmodeLocal", "f16"];
		[_vehicle] call orbis_gpws_fnc_f16GPWSinit;
	};
	case ("rita"): {
		_vehicle setVariable ["orbis_gpws_GPWSmodeLocal", "rita"];
		[_vehicle] call orbis_gpws_fnc_ritaGPWSinit;
	};
	default {};
};
