// init global variables
orbis_aerodynamics_loopFrameInterval = 1;
orbis_aerodynamics_pylonDragRatio = 0.001; // Cd 0.1 for FIR Mk84
orbis_aerodynamics_massStandardRatio = 0.8;
orbis_aerodynamics_dragMultiplier = 1;
orbis_aerodynamics_thrustMultiplier = 1;
orbis_aerodynamics_altitudeMultiplier = 1;
orbis_aerodynamics_dragSourceMultiplier = [1.0, 0.1, 1.0];
orbis_aerodynamics_thrustFactor = 7.2;
orbis_aerodynamics_liftGFactor = 2.5;
orbis_aerodynamics_waveCdArray = [0.7, 0.98, 1.0, 1.03, 2.4, 0.2, 0.1, -3.5];
orbis_aerodynamics_wingSpan = 12;
orbis_aerodynamics_geLiftMultiplier = 1.4;
orbis_aerodynamics_geInducedDragMultiplier = 0.3;
orbis_aerodynamics_noForceoOnGround = false;

// add EventHandlers
player addEventHandler ["GetInMan", {_this call orbis_aerodynamics_fnc_eventGetInMan}];
addMissionEventHandler ["EachFrame", {[] call orbis_aerodynamics_fnc_eachFrameHandler}];

if !(vehicle player isEqualTo player) then {
	[player, "", vehicle player, []] call orbis_aerodynamics_fnc_eventGetInMan;
};

["Plane", "init", {_this call orbis_aerodynamics_fnc_vehicleInit}, true, [], true] call CBA_fnc_addClassEventHandler;
