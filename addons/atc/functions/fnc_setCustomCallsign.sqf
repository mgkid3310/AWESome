#include "script_component.hpp"

params ["_vehicle", "_customCallsign"];

_vehicle setVariable [QGVAR(vehicleCallsign), _customCallsign, true];
