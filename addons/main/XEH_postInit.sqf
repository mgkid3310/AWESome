#include "script_component.hpp"

player setVariable [QGVAR(hasAWESomeMain), true, true];

// setup ACE Interactions
if (GVAR(hasACEInteractMenu)) then {
	[] call FUNC(setupACEInteractMenu);
};

// add EventHandlers
addMissionEventHandler ["EachFrame", {[] call FUNC(eachFrameHandler)}];
