orbis_ground_perFrame = 1;
orbis_ground_maxSpeedFoward = 5; // km/h
orbis_ground_maxSpeedReverse = 20; // km/h

orbis_ground_velBase = 0.9;
orbis_ground_Pconst = 0.4;
orbis_ground_Iconst = 0.4;
orbis_ground_Dconst = 0.2;

orbis_ground_minIntegralItem = 25;
orbis_ground_maxIntegralItem = 30;

// add actions (ACE / vanilla)
if (orbis_awesome_hasACEInteractMenu) then {
    [] call orbis_ground_fnc_addACEInteractMenu;
} else {
    if !(vehicle player isEqualTo player) then {
    	[player, "", vehicle player, []] call orbis_ground_fnc_getInAddAction;
    };
    player addEventHandler ["GetInMan", {_this call orbis_ground_fnc_getInAddAction}];
};
