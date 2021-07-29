#include "script_component.hpp"

params ["_className"];

GVAR(landingSpeed) = getNumber (configFile >> 'CfgVehicles' >> (typeOf vehicle player) >> 'landingSpeed') / EGVAR(main,km2NM);
GVAR(lastChecklist) = GVAR(currentChecklist);
GVAR(currentChecklist) = _className;
230 cutRsc [_className, "PLAIN"];
