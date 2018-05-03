class CfgPatches {
	class orbis_gpws {
		name = "Orbis GPWS";
		author = "Orbis2358";
		requiredVersion = 0.1;
		requiredAddons[] = {};
		units[] = {};
		weapons[] = {};
	};
};

#include "CfgEventHandlers.hpp"
#include "CfgSounds.hpp"

#define GPWS_F16 "f16"
#define GPWS_B747 "b747"
#define GPWS_NONE ""

#define LOW_CM_OFF -1
#define LOW_CM_DEFAULT 60

class CfgVehicles {
	class Plane;
	class Plane_CAS_01_base_F;
	class Plane_Fighter_03_base_F;

	// JS_JC
	class JS_JC_FA18E: Plane {
		orbisGPWS_enabled = 1;
		orbisGPWS_default = GPWS_F16;
		orbisGPWS_lowCMcount = LOW_CM_DEFAULT;

		#include "ACE_SelfActions.hpp"

		class UserActions {
			class HMD_ON {
				displayName = "HMD ON";
				position = "pilotcontrol";
				onlyforplayer = 1;
				showWindow = 0;
				hideOnUse = 1;
				radius = 15;
				condition = "player in this and isengineon this and this getvariable [""AWS_HMD"", ""no""] == ""no""";
				statement = "this setvariable [""AWS_HMD"", ""no""]; [this,1] execVM ""\FIR_AirWeaponSystem_US\Script\function\AWS_HMD.sqf"";";
			};		
			class HMD_OFF {
				displayName = "HMD OFF";
				position = "pilotcontrol";
				onlyforplayer = 1;
				showWindow = 0;
				hideOnUse = 1;
				radius = 15;
				condition = "player in this and isengineon this and this getvariable ""AWS_HMD"" == ""yes""";
				statement = "[this,1] execVM ""\FIR_AirWeaponSystem_US\Script\function\AWS_HMD.sqf"";";
			};	
		};

		class MFD {
			#include "FIR_F16_HMD.hpp"
		};
	};
	class JS_JC_FA18F: Plane {
		orbisGPWS_enabled = 1;
		orbisGPWS_default = GPWS_F16;
		orbisGPWS_lowCMcount = LOW_CM_DEFAULT;

		#include "ACE_SelfActions.hpp"

		class UserActions {
			class HMD_ON {
				displayName = "HMD ON";
				position = "pilotcontrol";
				onlyforplayer = 1;
				showWindow = 0;
				hideOnUse = 1;
				radius = 15;
				condition = "player in this and isengineon this and this getvariable [""AWS_HMD"", ""no""] == ""no""";
				statement = "this setvariable [""AWS_HMD"", ""no""]; [this,1] execVM ""\FIR_AirWeaponSystem_US\Script\function\AWS_HMD.sqf"";";
			};		
			class HMD_OFF {
				displayName = "HMD OFF";
				position = "pilotcontrol";
				onlyforplayer = 1;
				showWindow = 0;
				hideOnUse = 1;
				radius = 15;
				condition = "player in this and isengineon this and this getvariable ""AWS_HMD"" == ""yes""";
				statement = "[this,1] execVM ""\FIR_AirWeaponSystem_US\Script\function\AWS_HMD.sqf"";";
			};	
		};

		class MFD {
			#include "FIR_F16_HMD.hpp"
		};
	};
	class JS_JC_SU35: Plane {
		orbisGPWS_enabled = 1;
		orbisGPWS_default = GPWS_NONE;
		orbisGPWS_lowCMcount = LOW_CM_DEFAULT;

		#include "ACE_SelfActions.hpp"
	};

	// FIR
	class FIR_A10A_Base: Plane_CAS_01_base_F {
		orbisGPWS_enabled = 1;
		orbisGPWS_default = GPWS_F16;
		orbisGPWS_lowCMcount = LOW_CM_DEFAULT;

		#include "ACE_SelfActions.hpp"
	};
	class FIR_A10C_Base: Plane_CAS_01_base_F {
		orbisGPWS_enabled = 1;
		orbisGPWS_default = GPWS_F16;
		orbisGPWS_lowCMcount = LOW_CM_DEFAULT;

		#include "ACE_SelfActions.hpp"
	};
	class FLAN_EA18G_Base: Plane_Fighter_03_base_F {
		orbisGPWS_enabled = 1;
		orbisGPWS_default = GPWS_F16;
		orbisGPWS_lowCMcount = LOW_CM_DEFAULT;

		#include "ACE_SelfActions.hpp"
	};
	class FIR_F14D_Base: Plane_Fighter_03_base_F {
		orbisGPWS_enabled = 1;
		orbisGPWS_default = GPWS_F16;
		orbisGPWS_lowCMcount = LOW_CM_DEFAULT;

		#include "ACE_SelfActions.hpp"
	};
	class FIR_F15_Base: Plane_Fighter_03_base_F {
		orbisGPWS_enabled = 1;
		orbisGPWS_default = GPWS_F16;
		orbisGPWS_lowCMcount = LOW_CM_DEFAULT;

		#include "ACE_SelfActions.hpp"
	};
	class FIR_F15D_Base: Plane_Fighter_03_base_F {
		orbisGPWS_enabled = 1;
		orbisGPWS_default = GPWS_F16;
		orbisGPWS_lowCMcount = LOW_CM_DEFAULT;

		#include "ACE_SelfActions.hpp"
	};	
	class FIR_F15E_Base: Plane_Fighter_03_base_F {
		orbisGPWS_enabled = 1;
		orbisGPWS_default = GPWS_F16;
		orbisGPWS_lowCMcount = LOW_CM_DEFAULT;

		#include "ACE_SelfActions.hpp"
	};
	class FIR_F16_Base: Plane_Fighter_03_base_F {
		orbisGPWS_enabled = 1;
		orbisGPWS_default = GPWS_F16;
		orbisGPWS_lowCMcount = LOW_CM_DEFAULT;

		#include "ACE_SelfActions.hpp"
	};
	class FIR_F16D_Base: Plane_Fighter_03_base_F {
		orbisGPWS_enabled = 1;
		orbisGPWS_default = GPWS_F16;
		orbisGPWS_lowCMcount = LOW_CM_DEFAULT;

		#include "ACE_SelfActions.hpp"
	};
	class FIR_F2A_Base: Plane_Fighter_03_base_F {
		orbisGPWS_enabled = 1;
		orbisGPWS_default = GPWS_F16;
		orbisGPWS_lowCMcount = LOW_CM_DEFAULT;

		#include "ACE_SelfActions.hpp"
	};
};
