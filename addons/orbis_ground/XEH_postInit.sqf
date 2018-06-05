orbis_ground_Pconst = -1;
orbis_ground_Iconst = -0.8;
orbis_ground_Dconst = -1;

if (orbis_awesome_hasACEInteractMenu) then {
    [] call orbis_ground_fnc_addACEInteractMenu;
} else {
    if !(vehicle player isEqualTo player) then {
    	[player, "", vehicle player, []] call orbis_ground_fnc_getInAddAction;
    };
    player addEventHandler ["GetInMan", {_this call orbis_ground_fnc_getInAddAction}];
};
