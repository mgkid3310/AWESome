#include "RscTitles_base.hpp"

class RscTitles {
	class none {
		idd = -1;
		fadein = 0;
		fadeout = 0;
		duration = 0;
	};

	class pre_start_checklist: checklist_base {
		class controls {
			class mainTexture: mainTexture_base {
				text = QPATHTOF(textures\01_Pre-start_Checklist.paa);
			};
			// class buttonPrevious: buttonPrevious_base {};
			// class buttonNext: buttonNext_base {};
		};
	};

	class startup_before_taxi_checklist: checklist_base {
		class controls {
			class mainTexture: mainTexture_base {
				text = QPATHTOF(textures\02_Startup_Before_Taxi_Checklist.paa);
			};
			// class buttonPrevious: buttonPrevious_base {};
			// class buttonNext: buttonNext_base {};
		};
	};

	class before_takeoff_checklist: checklist_base {
		class controls {
			class mainTexture: mainTexture_base {
				text = QPATHTOF(textures\03_Before_Takeoff_Checklist.paa);
			};
			// class buttonPrevious: buttonPrevious_base {};
			// class buttonNext: buttonNext_base {};
		};
	};

	class takeoff_checklist: checklist_base {
		class controls {
			class mainTexture: mainTexture_base {
				text = QPATHTOF(textures\04_Takeoff_Checklist.paa);
			};
			class text_v1: text_static_base {
				idc = 1811;
				y = "0.0004 * (228.1 + 45.8) * safezoneW + 0.2 * safezoneH + safezoneY";
				onLoad = QUOTE((_this select 0) ctrlSetText (((GVAR(landingSpeed) - 10) min 120) call FUNC(processSpeed)));
			};
			class text_vr: text_static_base {
				idc = 1812;
				y = "0.0004 * (228.1 + 45.8 * 2) * safezoneW + 0.2 * safezoneH + safezoneY";
				onLoad = QUOTE((_this select 0) ctrlSetText (GVAR(landingSpeed) call FUNC(processSpeed)));
			};
			class text_pitch: text_static_base {
				idc = 1813;
				y = "0.0004 * (228.1 + 45.8 * 3) * safezoneW + 0.2 * safezoneH + safezoneY";
				onLoad = QUOTE([_this select 0] call FUNC(setPitchNumber));
			};
			class text_v2: text_static_base {
				idc = 1814;
				y = "0.0004 * (228.1 + 45.8 * 4) * safezoneW + 0.2 * safezoneH + safezoneY";
				onLoad = QUOTE((_this select 0) ctrlSetText ((20 + GVAR(landingSpeed)) call FUNC(processSpeed)));
			};
			class text_flaps_1: text_static_base {
				idc = 1815;
				y = "0.0004 * (228.1 + 45.8 * 6) * safezoneW + 0.2 * safezoneH + safezoneY";
				onLoad = QUOTE((_this select 0) ctrlSetText ((60 + GVAR(landingSpeed)) call FUNC(processSpeed)));
			};
			class text_flaps_up: text_static_base {
				idc = 1816;
				y = "0.0004 * (228.1 + 45.8 * 7) * safezoneW + 0.2 * safezoneH + safezoneY";
				onLoad = QUOTE((_this select 0) ctrlSetText ((100 + GVAR(landingSpeed)) call FUNC(processSpeed)));
			};
			// class buttonPrevious: buttonPrevious_base {};
			// class buttonNext: buttonNext_base {};
		};
	};

	class descent_approach_checklist: checklist_base {
		class controls {
			class mainTexture: mainTexture_base {
				text = QPATHTOF(textures\05_Descent_Approach_Checklist.paa);
			};
			class text_descent_speed: text_static_base {
				idc = 1811;
				y = "0.0004 * (228.1 + 45.8 * 2) * safezoneW + 0.2 * safezoneH + safezoneY";
				onLoad = QUOTE((_this select 0) ctrlSetText ((60 + GVAR(landingSpeed)) call FUNC(processSpeed)));
			};
			class text_speed_establish: text_static_base {
				idc = 1812;
				y = "0.0004 * (723.6 + 45.8 * 3) * safezoneW + 0.2 * safezoneH + safezoneY";
				onLoad = QUOTE((_this select 0) ctrlSetText ((30 + GVAR(landingSpeed)) call FUNC(processSpeed)));
			};
			// class buttonPrevious: buttonPrevious_base {};
			// class buttonNext: buttonNext_base {};
		};
	};

	class landing_taxi_to_ramp_checklist: checklist_base {
		class controls {
			class mainTexture: mainTexture_base {
				text = QPATHTOF(textures\06_Landing_Taxi_To_Ramp_Checklist.paa);
			};
			class text_landing_speed: text_static_base {
				idc = 1811;
				y = "0.0004 * (228.1 + 45.8 * 2) * safezoneW + 0.2 * safezoneH + safezoneY";
				onLoad = QUOTE((_this select 0) ctrlSetText (GVAR(landingSpeed) call FUNC(processSpeed)));
			};
			// class buttonPrevious: buttonPrevious_base {};
			// class buttonNext: buttonNext_base {};
		};
	};
};
