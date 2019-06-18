#include "script_component.hpp"
ADDON = false;
#include "XEH_PREP.hpp"
ADDON = true;

// set devmode
AWESOME_DEVMODE_LOG = false;

// check if has ACE modules
GVAR(hasACEInteractMenu) = isClass (configFile >> "CfgPatches" >> "ace_interact_menu");
GVAR(hasACEMap) = isClass (configFile >> "CfgPatches" >> "ace_map");
GVAR(hasACEUnits) = isClass (configFile >> "CfgPatches" >> "ace_units");
GVAR(hasACEWeather) = isClass (configFile >> "CfgPatches" >> "ace_weather");
GVAR(hasACEUnits) = isClass (configFile >> "CfgPatches" >> "ace_units");

// init actions variable
GVAR(ACEInteractions) = [];

// add ACE action
if (GVAR(hasACEInteractMenu)) then {
	[] call FUNC(addACEInteractMenu);
};
