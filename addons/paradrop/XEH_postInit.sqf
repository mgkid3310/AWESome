// init c-17 system
awesome_paradrop_loopFrameInterval = 4;
[] call awesome_paradrop_fnc_attachUpdate;
addMissionEventHandler ["EachFrame", {[] call awesome_paradrop_fnc_eachFrameHandler}];
