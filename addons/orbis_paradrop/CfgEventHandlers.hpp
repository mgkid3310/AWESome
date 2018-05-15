class Extended_PreStart_EventHandlers {
	class orbis_paradrop {
		init = "call compile preProcessFileLineNumbers 'orbis_paradrop\XEH_preStart.sqf'";
	};
};

class Extended_PreInit_EventHandlers {
	class orbis_paradrop {
		init = "call compile preProcessFileLineNumbers 'orbis_paradrop\XEH_preInit.sqf'";
	};
};

class Extended_PostInit_EventHandlers {
	class orbis_paradrop {
		init = "call compile preProcessFileLineNumbers 'orbis_paradrop\XEH_postInit.sqf'";
	};
};
