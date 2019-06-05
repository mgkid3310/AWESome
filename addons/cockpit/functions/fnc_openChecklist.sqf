#include "script_component.hpp"

private _className = _this select 0;

GVAR(landingSpeed) = EGVAR(main,kphToKnot) * getNumber (configFile >> 'CfgVehicles' >> (typeOf vehicle player) >> 'landingSpeed');
GVAR(lastChecklist) = GVAR(currentChecklist);
GVAR(currentChecklist) = _className;
230 cutRsc [_className, "PLAIN"];
