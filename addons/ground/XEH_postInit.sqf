awesome_ground_perFrame = 1;
awesome_ground_maxSpeedFoward = 5; // km/h
awesome_ground_maxSpeedReverse = 20; // km/h

awesome_ground_velBase = 0.9;
awesome_ground_Pconst = 0.4;
awesome_ground_Iconst = 0.4;
awesome_ground_Dconst = 0.2;

awesome_ground_minIntegralItem = 25;
awesome_ground_maxIntegralItem = 30;

// add actions (ACE / vanilla)
if (awesome_awesome_hasACEInteractMenu) then {
    [] call awesome_ground_fnc_addACEInteractMenu;
} else {
    if !(vehicle player isEqualTo player) then {
    	[player, "", vehicle player, []] call awesome_ground_fnc_getInAddAction;
    };
    player addEventHandler ["GetInMan", {_this call awesome_ground_fnc_getInAddAction}];
};
