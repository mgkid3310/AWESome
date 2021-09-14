#define GPWS_F16 "f16"
#define GPWS_B747 "b747"
#define GPWS_NONE ""

#define LOW_CM_OFF -1
#define LOW_CM_DEFAULT 60

class CfgVehicles {
	class Air;
	class Plane: Air {
		GVAR(isGPWSenabled) = 1;
		GVAR(defaultGPWS) = GPWS_NONE;
		GVAR(lowCMcount) = 20;
	};
	class Plane_Base_F: Plane {};
	class Plane_CAS_01_base_F: Plane_Base_F {};
	class Plane_Fighter_03_base_F: Plane_Base_F {};

	// JS_JC
	class JS_JC_FA18E: Plane {
		GVAR(defaultGPWS) = GPWS_NONE;
		GVAR(lowCMcount) = LOW_CM_DEFAULT;
	};
	class JS_JC_FA18F: Plane {
		GVAR(defaultGPWS) = GPWS_NONE;
		GVAR(lowCMcount) = LOW_CM_DEFAULT;
	};
	class JS_JC_SU35: Plane {
		GVAR(defaultGPWS) = GPWS_NONE;
		GVAR(lowCMcount) = LOW_CM_DEFAULT;
	};

	// FIR
	class FIR_A10A_Base: Plane_CAS_01_base_F {
		GVAR(defaultGPWS) = GPWS_NONE;
		GVAR(lowCMcount) = LOW_CM_DEFAULT;
	};
	class FIR_A10C_Base: Plane_CAS_01_base_F {
		GVAR(defaultGPWS) = GPWS_NONE;
		GVAR(lowCMcount) = LOW_CM_DEFAULT;
	};
	class FIR_AV8B_Base: Plane_Fighter_03_base_F {
		GVAR(defaultGPWS) = GPWS_NONE;
		GVAR(lowCMcount) = LOW_CM_DEFAULT;
	};
	class FIR_AV8B_NA_Base: Plane_Fighter_03_base_F {
		GVAR(defaultGPWS) = GPWS_NONE;
		GVAR(lowCMcount) = LOW_CM_DEFAULT;
	};
	class FIR_AV8B_GR7_Base: Plane_Fighter_03_base_F {
		GVAR(defaultGPWS) = GPWS_NONE;
		GVAR(lowCMcount) = LOW_CM_DEFAULT;
	};
	class FLAN_EA18G_Base: Plane_Fighter_03_base_F {
		GVAR(defaultGPWS) = GPWS_NONE;
		GVAR(lowCMcount) = LOW_CM_DEFAULT;
	};
	class FIR_F14D_Base: Plane_Fighter_03_base_F {
		GVAR(defaultGPWS) = GPWS_NONE;
		GVAR(lowCMcount) = LOW_CM_DEFAULT;
	};
	class FIR_F15_Base: Plane_Fighter_03_base_F {
		GVAR(defaultGPWS) = GPWS_NONE;
		GVAR(lowCMcount) = LOW_CM_DEFAULT;
	};
	class FIR_F15D_Base: Plane_Fighter_03_base_F {
		GVAR(defaultGPWS) = GPWS_NONE;
		GVAR(lowCMcount) = LOW_CM_DEFAULT;
	};
	class FIR_F15E_Base: Plane_Fighter_03_base_F {
		GVAR(defaultGPWS) = GPWS_NONE;
		GVAR(lowCMcount) = LOW_CM_DEFAULT;
	};
	class FIR_F16_Base: Plane_Fighter_03_base_F {
		GVAR(defaultGPWS) = GPWS_F16;
		GVAR(lowCMcount) = LOW_CM_DEFAULT;
	};
	class FIR_F16D_Base: Plane_Fighter_03_base_F {
		GVAR(defaultGPWS) = GPWS_F16;
		GVAR(lowCMcount) = LOW_CM_DEFAULT;
	};
	class FIR_F2A_Base: Plane_Fighter_03_base_F {
		GVAR(defaultGPWS) = GPWS_F16;
		GVAR(lowCMcount) = LOW_CM_DEFAULT;
	};
};
