orbis_atc_scaleStd = 0.0015;
if (isNumber (configFile >> "CfgWorlds" >> worldName >> "mapSize")) then {
    orbis_atc_scaleStd = (orbis_atc_scaleStd * 30720) / getNumber (configFile >> "CfgWorlds" >> worldName >> "mapSize");
};
orbis_atc_fontMin = 0.05;
orbis_atc_fontMax = 0.1;
orbis_atc_lineSpacing = 0.9;
