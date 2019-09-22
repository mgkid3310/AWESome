#include "script_component.hpp"

params ["_control"];

private _angleConfig = (configFile >> 'CfgVehicles' >> (typeOf vehicle player) >> 'landingAoa');

if (isNumber _angleConfig) then {
	_control ctrlSetText str round deg getNumber _angleConfig;
} else {
	_control ctrlSetText str round deg (call compile getText _angleConfig);
};
