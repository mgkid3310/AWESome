class CfgPatches {
	class orbis_atc_environment {
		name = "Orbis ATC Environment";
		author = "Orbis2358";
		requiredVersion = 0.1;
		requiredAddons[] = {};
		units[] = {};
		weapons[] = {};
	};
};

#include "CfgEventHandlers.hpp"
#include "CfgSounds.hpp"

class CfgVehicles {
	class Plane;
	class Plane_Base_F: Plane {
		class ACE_SelfActions {
			class orbisListenATIS {
				displayName = "Listen to ATIS";
				condition = "(_target getVariable ['orbisATISready', true]) && (_player isEqualTo driver _target)";
				statement = "[] call orbis_atc_fnc_listenATISbroadcast";
				showDisabled = 0;
				priority = 0.6;
				icon = "";
			};
		};
	};
};
