class Extended_PreStart_EventHandlers {
	class orbis_ground {
		init = "call compile preProcessFileLineNumbers 'orbis_ground\XEH_preStart.sqf'";
	};
};

class Extended_PreInit_EventHandlers {
	class orbis_ground {
		init = "call compile preProcessFileLineNumbers 'orbis_ground\XEH_preInit.sqf'";
	};
};

class Extended_PostInit_EventHandlers {
	class orbis_ground {
		init = "call compile preProcessFileLineNumbers 'orbis_ground\XEH_postInit.sqf'";
	};
};
