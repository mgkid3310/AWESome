#include "script_component.hpp"

params ["_className"];

GVAR(landingSpeed) = EGVAR(main,kphToKnot) * getNumber (configFile >> 'CfgVehicles' >> (typeOf vehicle player) >> 'landingSpeed');
GVAR(lastChecklist) = GVAR(currentChecklist);
GVAR(currentChecklist) = _className;
230 cutRsc [_className, "PLAIN"];
