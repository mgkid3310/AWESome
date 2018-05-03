class Extended_PreStart_EventHandlers {
	class orbis_atc_environment {
		init = "call compile preProcessFileLineNumbers 'orbis_atc_environment\XEH_preStart.sqf'";
	};
};

class Extended_PreInit_EventHandlers {
	class orbis_atc_environment {
		init = "call compile preProcessFileLineNumbers 'orbis_atc_environment\XEH_preInit.sqf'";
	};
};

class Extended_PostInit_EventHandlers {
	class orbis_atc_environment {
		init = "call compile preProcessFileLineNumbers 'orbis_atc_environment\XEH_postInit.sqf'";
	};
};
