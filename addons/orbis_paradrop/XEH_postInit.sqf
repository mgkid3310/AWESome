// init c-17 system
[] call orbis_paradrop_fnc_attachUpdate;
addMissionEventHandler ["EachFrame", {
	[] call orbis_paradrop_fnc_attachRun;
	[] call orbis_paradrop_fnc_attachUpdate;
}];
