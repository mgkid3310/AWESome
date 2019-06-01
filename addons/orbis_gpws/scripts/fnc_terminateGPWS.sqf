private _vehicle = param [0, vehicle player];
private _mode = param [1, "off"];

switch (_mode) do {
	case ("b747"): {
		_vehicle setVariable ["orbis_gpws_GPWSmodeLocal", "off"];
		[_vehicle] call orbis_gpws_fnc_b747GPWSterminate;
	};
	case ("f16"): {
		_vehicle setVariable ["orbis_gpws_GPWSmodeLocal", "off"];
		[_vehicle] call orbis_gpws_fnc_f16GPWSterminate;
	};
	case ("rita"): {
		_vehicle setVariable ["orbis_gpws_GPWSmodeLocal", "off"];
		[_vehicle] call orbis_gpws_fnc_ritaGPWSterminate;
	};
	default {};
};
