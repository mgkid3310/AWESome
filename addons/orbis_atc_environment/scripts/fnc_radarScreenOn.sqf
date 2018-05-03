if (player getVariable ["isUsingRadarScreen", false]) exitWith {};

_this spawn orbis_atc_fnc_atcRadarLoop;
