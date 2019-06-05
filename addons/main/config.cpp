#include "script_component.hpp"

class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		author = "Orbis2358";
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"cba_common"};
		units[] = {};
		weapons[] = {};
	};
};

#include "CfgEventHandlers.hpp"
