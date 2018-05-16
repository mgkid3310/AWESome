private _timeOld = missionNamespace getVariable ["orbis_paradrop_timeOld", -1];
private _frameOld = missionNamespace getVariable ["orbis_paradrop_frameOld", -1];

if ((_timeOld < 0) || (_frameOld < 0)) exitWith {
    missionNamespace setVariable ["orbis_paradrop_timeOld", time];
    missionNamespace setVariable ["orbis_paradrop_frameOld", diag_frameNo];
};
if (diag_frameNo < (_frameOld + orbis_paradrop_loopFrameInterval)) exitWith {};

[] call orbis_paradrop_fnc_attachRun;
[] call orbis_paradrop_fnc_attachUpdate;

missionNamespace setVariable ["orbis_paradrop_timeOld", time];
missionNamespace setVariable ["orbis_paradrop_frameOld", diag_frameNo];
