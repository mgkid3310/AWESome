#include "script_component.hpp"

// init c-17 system
GVAR(loopFrameInterval) = 4;
[] call FUNC(attachUpdate);
addMissionEventHandler ["EachFrame", {[] call FUNC(eachFrameHandler)}];
