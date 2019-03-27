player setVariable ["hasOrbisATC", true, true];

orbis_atc_xOffset = 0.8;
orbis_atc_yOffset = -0.3;

orbis_atc_scaleStd = 0.0015;
if (isNumber (configFile >> "CfgWorlds" >> worldName >> "mapSize")) then {
    orbis_atc_scaleStd = (orbis_atc_scaleStd * 30720) / getNumber (configFile >> "CfgWorlds" >> worldName >> "mapSize");
};
orbis_atc_fontMax = 0.1;
orbis_atc_fontMin = 0.05;
orbis_atc_spaceMax = 1.5;
orbis_atc_spaceMin = 0.75;

// run initial ATIS data update
[] spawn {
    sleep 10;
    [] call orbis_atc_fnc_updateATISdata;
};

// run periodic check
[] spawn orbis_atc_fnc_periodicCheck;
