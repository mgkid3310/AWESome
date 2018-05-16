// init c-17 system
orbis_paradrop_loopFrameInterval = 4;
[] call orbis_paradrop_fnc_attachUpdate;
addMissionEventHandler ["EachFrame", {[] call orbis_paradrop_fnc_eachFrameHandler}];
