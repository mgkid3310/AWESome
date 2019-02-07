player setVariable ["hasOrbisATC", true, true];

awesome_atc_xOffset = 0.8;
awesome_atc_yOffset = -0.3;

awesome_atc_scaleStd = 0.0015;
if (isNumber (configFile >> "CfgWorlds" >> worldName >> "mapSize")) then {
    awesome_atc_scaleStd = (awesome_atc_scaleStd * 30720) / getNumber (configFile >> "CfgWorlds" >> worldName >> "mapSize");
};
awesome_atc_fontMax = 0.1;
awesome_atc_fontMin = 0.05;
awesome_atc_spaceMax = 1.5;
awesome_atc_spaceMin = 0.75;

// add actions (ACE / vanilla)
if (awesome_awesome_hasACEInteractMenu) then {
    [] call awesome_atc_fnc_addACEInteractMenu;
} else {
    if !(vehicle player isEqualTo player) then {
    	[player, "", vehicle player, []] call awesome_atc_fnc_getInAddAction;
    };
    player addEventHandler ["GetInMan", {_this call awesome_atc_fnc_getInAddAction}];
};

// run initial ATIS data update
[] spawn {
    sleep 10;
    [] call awesome_atc_fnc_updateATISdata;
};

// run periodic check
[] spawn awesome_atc_fnc_periodicCheck;
