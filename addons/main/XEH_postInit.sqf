#include "script_component.hpp"

missionNamespace setVariable [QGVAR(hasAWESomeMain_) + getPlayerUID player, true, true];

// setup ACE Interactions
if (GVAR(hasACEInteractMenu)) then {
	[] call FUNC(setupACEInteractMenu);
};

// add EventHandlers
[QGVAR(playSoundVehicle), {_this call FUNC(playSoundVehicle)}] call CBA_fnc_addEventHandler;
addMissionEventHandler ["EachFrame", {[] call FUNC(eachFrameHandler)}];

/* orbis_temp = {
	params ["_standard", "_insideSoundCoef"];

	ln (_standard / _insideSoundCoef);
}; */
