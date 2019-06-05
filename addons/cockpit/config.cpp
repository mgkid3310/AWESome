#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		author = "Orbis2358";
		requiredVersion = 1.84;
		requiredAddons[] = {"awesome_main"};
		units[] = {};
		weapons[] = {};
	};
};

#include "CfgEventHandlers.hpp"
#include "RscTitles.hpp"
