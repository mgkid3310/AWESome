#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

// set devmode
AWESOME_DEVMODE_LOG = false;

// init global variables
GVAR(ftToM) = 0.3048;
GVAR(mToFt) = 1 / GVAR(ftToM);
GVAR(knotToMps) = 0.514444;
GVAR(kphToKnot) = 1 / GVAR(knotToMps);
GVAR(knotToKph) = 1.852;
GVAR(kphToKnot) = 1 / GVAR(knotToKph);

// check if has ACE modules
GVAR(hasACEInteractMenu) = isClass (configFile >> "CfgPatches" >> "ace_interact_menu");
GVAR(hasACEMap) = isClass (configFile >> "CfgPatches" >> "ace_map");
GVAR(hasACEUnits) = isClass (configFile >> "CfgPatches" >> "ace_units");
GVAR(hasACEWeather) = isClass (configFile >> "CfgPatches" >> "ace_weather");

// init actions variable
GVAR(ACEInteractions) = [];

// add ACE action
if (GVAR(hasACEInteractMenu)) then {
	[] call FUNC(addACEInteractMenu);
};
