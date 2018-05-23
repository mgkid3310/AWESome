class Extended_PreStart_EventHandlers {
	class orbis_awesome_main {
		init = "call compile preProcessFileLineNumbers 'orbis_awesome_main\XEH_preStart.sqf'";
	};
};

class Extended_PreInit_EventHandlers {
	class orbis_awesome_main {
		init = "call compile preProcessFileLineNumbers 'orbis_awesome_main\XEH_preInit.sqf'";
	};
};

class Extended_PostInit_EventHandlers {
	class orbis_awesome_main {
		init = "call compile preProcessFileLineNumbers 'orbis_awesome_main\XEH_postInit.sqf'";
	};
};
