// init global variables
orbis_awesome_ftToM = 0.3048;
orbis_awesome_mToFt = 1 / orbis_awesome_ftToM;
orbis_awesome_knotToMps = 0.514444;
orbis_awesome_kphToKnot = 1 / orbis_awesome_knotToMps;
orbis_awesome_knotToKph = 1.852;
orbis_awesome_kphToKnot = 1 / orbis_awesome_knotToKph;

// setup ACE Interactions
if (orbis_awesome_hasACEInteractMenu) then {
	[] call orbis_awesome_fnc_setupACEInteractMenu;
};
