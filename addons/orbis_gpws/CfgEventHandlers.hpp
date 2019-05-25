class Extended_PreStart_EventHandlers {
	class orbis_gpws {
		init = "call compile preProcessFileLineNumbers 'orbis_gpws\XEH_preStart.sqf'";
	};
};

class Extended_PreInit_EventHandlers {
	class orbis_gpws {
		init = "call compile preProcessFileLineNumbers 'orbis_gpws\XEH_preInit.sqf'";
	};
};

class Extended_PostInit_EventHandlers {
	class orbis_gpws {
		init = "call compile preProcessFileLineNumbers 'orbis_gpws\XEH_postInit.sqf'";
	};
};
