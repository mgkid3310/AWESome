// check if has ACE modules
orbis_awesome_hasACEMap = isClass (configFile >> "CfgPatches" >> "ace_map");
orbis_awesome_hasACEInteractMenu = isClass (configFile >> "CfgPatches" >> "ace_interact_menu");
orbis_awesome_hasACEWeather = isClass (configFile >> "CfgPatches" >> "ace_weather");

// add base action for ACE Interaction
if (orbis_awesome_hasACEInteractMenu) then {
    private _actionMain = [
    	"AWESome",
    	"AWESome",
    	"",
    	{},
    	{[] call orbis_atc_fnc_isCrew},
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
