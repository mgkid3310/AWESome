// init global variable
awesome_aerodynamics_pylonDragRatio = 0.001; // Cd 0.1 for FIR Mk84
awesome_aerodynamics_massStandardRatio = 0.8;
awesome_aerodynamics_altitudeMultiplier = 0.5;
awesome_aerodynamics_dragSourceMultiplier = [1.0, 0.1, 1.0];
awesome_aerodynamics_liftGFactor = 2.5;
awesome_aerodynamics_waveCdArray = [0.7, 0.98, 1.0, 1.03, 2.4, 0.2, 0.1, -3.5];

// add EventHandlers
player addEventHandler ["GetInMan", {_this call awesome_aerodynamics_fnc_eventGetInMan}];
addMissionEventHandler ["EachFrame", {[] call awesome_aerodynamics_fnc_eachFrameHandler}];

if !(vehicle player isEqualTo player) then {
	[player, "", vehicle player, []] call awesome_aerodynamics_fnc_eventGetInMan;
};

["Plane", "init", {_this call awesome_aerodynamics_fnc_vehicleInit}, true, [], true] call CBA_fnc_addClassEventHandler;
