class Extended_PreStart_EventHandlers {
	class orbis_aerodynamics {
		init = "call compile preProcessFileLineNumbers 'orbis_aerodynamics\XEH_preStart.sqf'";
	};
};

class Extended_PreInit_EventHandlers {
	class orbis_aerodynamics {
		init = "call compile preProcessFileLineNumbers 'orbis_aerodynamics\XEH_preInit.sqf'";
	};
};

class Extended_PostInit_EventHandlers {
	class orbis_aerodynamics {
		init = "call compile preProcessFileLineNumbers 'orbis_aerodynamics\XEH_postInit.sqf'";
	};
};
