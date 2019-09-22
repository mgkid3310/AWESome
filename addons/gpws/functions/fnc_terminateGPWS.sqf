#include "script_component.hpp"

params [["_vehicle", vehicle player], ["_mode", "off"]];

switch (_mode) do {
	case ("b747"): {
		_vehicle setVariable [QGVAR(GPWSmodeLocal), "off"];
		[_vehicle] call FUNC(b747GPWSterminate);
	};
	case ("f16"): {
		_vehicle setVariable [QGVAR(GPWSmodeLocal), "off"];
		[_vehicle] call FUNC(f16GPWSterminate);
	};
	case ("rita"): {
		_vehicle setVariable [QGVAR(GPWSmodeLocal), "off"];
		[_vehicle] call FUNC(ritaGPWSterminate);
	};
	default {};
};
