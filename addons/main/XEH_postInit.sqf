#include "script_component.hpp"

// init global variables
GVAR(ftToM) = 0.3048;
GVAR(mToFt) = 1 / GVAR(ftToM);
GVAR(knotToMps) = 0.514444;
GVAR(kphToKnot) = 1 / GVAR(knotToMps);
GVAR(knotToKph) = 1.852;
GVAR(kphToKnot) = 1 / GVAR(knotToKph);

// setup ACE Interactions
if (GVAR(hasACEInteractMenu)) then {
	[] call FUNC(setupACEInteractMenu);
};
