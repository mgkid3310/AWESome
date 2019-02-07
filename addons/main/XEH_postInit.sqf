AWESOME_DEVMODE_LOG = false;

// check if has ACE modules
awesome_awesome_hasACEMap = isClass (configFile >> "CfgPatches" >> "ace_map");
awesome_awesome_hasACEInteractMenu = isClass (configFile >> "CfgPatches" >> "ace_interact_menu");
awesome_awesome_hasACEWeather = isClass (configFile >> "CfgPatches" >> "ace_weather");

// global values
awesome_awesome_ftToM = 0.3048;
awesome_awesome_mToFt = 1 / awesome_awesome_ftToM;
awesome_awesome_knotToKph = 1.852;
awesome_awesome_kphToKnot = 1 / awesome_awesome_knotToKph;

// add base action for ACE Interaction
if (awesome_awesome_hasACEInteractMenu) then {
    private _actionMain = [
    	"AWESome",
    	"AWESome",
    	"",
    	{},
    	{[] call awesome_atc_fnc_isCrew},
    	{},
    	[],
    	[0, 0, 0],
    	10
    ] call ace_interact_menu_fnc_createAction;

    [
    	"Plane",
    	1,
    	["ACE_SelfActions"],
    	_actionMain,
        true
    ] call ace_interact_menu_fnc_addActionToClass;
    [
    	"Helicopter",
    	1,
    	["ACE_SelfActions"],
    	_actionMain,
        true
    ] call ace_interact_menu_fnc_addActionToClass;
};
