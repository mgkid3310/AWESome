#include "script_component.hpp"

private _vehicle = param [0, vehicle player];
private _mode = param [1, "off"];

switch (_mode) do {
	case ("b747"): {
		_vehicle setVariable [QGVAR(GPWSmodeLocal), "b747"];
		[_vehicle] call FUNC(b747GPWSinit);
	};
	case ("f16"): {
		_vehicle setVariable [QGVAR(GPWSmodeLocal), "f16"];
		[_vehicle] call FUNC(f16GPWSinit);
	};
	case ("rita"): {
		_vehicle setVariable [QGVAR(GPWSmodeLocal), "rita"];
		[_vehicle] call FUNC(ritaGPWSinit);
	};
	default {};
};
