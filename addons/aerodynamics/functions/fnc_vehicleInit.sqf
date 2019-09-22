#include "script_component.hpp"

params ["_vehicle"];

private _aeroConfigs = _vehicle getVariable [QGVAR(aeroConfig), false];
if !(_aeroConfigs isEqualType []) then {
	_aeroConfigs = [_vehicle] call FUNC(getAeroConfig);
	_vehicle setVariable [QGVAR(aeroConfig), _aeroConfigs, true];
};

// report if needed (dev script)
// diag_log format ["orbis_aerodynamics _vehicle: %1, _aeroConfigs: %2", _vehicle, _aeroConfigs];
