#include "script_component.hpp"

// init global variables
GVAR(perFrame) = 1;
GVAR(maxSpeedFoward) = 5; // km/h
GVAR(maxSpeedReverse) = 20; // km/h

GVAR(velBase) = 0.9;
GVAR(Pconst) = 0.4;
GVAR(Iconst) = 0.4;
GVAR(Dconst) = 0.2;

GVAR(minIntegralItem) = 25;
GVAR(maxIntegralItem) = 30;
