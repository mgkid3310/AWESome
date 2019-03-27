#include "XEH_PREP.sqf"

// set devmode
AWESOME_DEVMODE_LOG = false;

// check if has ACE modules
orbis_awesome_hasACEMap = isClass (configFile >> "CfgPatches" >> "ace_map");
orbis_awesome_hasACEInteractMenu = isClass (configFile >> "CfgPatches" >> "ace_interact_menu");
orbis_awesome_hasACEWeather = isClass (configFile >> "CfgPatches" >> "ace_weather");

// init actions variable
orbis_awesome_ACEInteractions = [];

// add ACE action
if (orbis_awesome_hasACEInteractMenu) then {
    [] call orbis_awesome_fnc_addACEInteractMenu;
};
