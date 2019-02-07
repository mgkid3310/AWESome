#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		name = COMPONENT;
		author = "Orbis2358";
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"awesome_main"};
		units[] = {};
		weapons[] = {};
	};
};

#include "CfgEventHandlers.hpp"
#include "dialogs.hpp"
