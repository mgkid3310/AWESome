class Extended_PreStart_EventHandlers {
	class orbis_cockpit {
		init = "call compile preProcessFileLineNumbers 'orbis_cockpit\XEH_preStart.sqf'";
	};
};

class Extended_PreInit_EventHandlers {
	class orbis_cockpit {
		init = "call compile preProcessFileLineNumbers 'orbis_cockpit\XEH_preInit.sqf'";
	};
};

class Extended_PostInit_EventHandlers {
	class orbis_cockpit {
		init = "call compile preProcessFileLineNumbers 'orbis_cockpit\XEH_postInit.sqf'";
	};
};
