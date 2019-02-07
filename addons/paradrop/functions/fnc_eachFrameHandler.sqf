private _timeOld = missionNamespace getVariable ["awesome_paradrop_timeOld", -1];
private _frameOld = missionNamespace getVariable ["awesome_paradrop_frameOld", -1];

if ((_timeOld < 0) || (_frameOld < 0)) exitWith {
    missionNamespace setVariable ["awesome_paradrop_timeOld", time];
    missionNamespace setVariable ["awesome_paradrop_frameOld", diag_frameNo];
};
if (diag_frameNo < (_frameOld + awesome_paradrop_loopFrameInterval)) exitWith {};

[] call awesome_paradrop_fnc_attachRun;
[] call awesome_paradrop_fnc_attachUpdate;

missionNamespace setVariable ["awesome_paradrop_timeOld", time];
missionNamespace setVariable ["awesome_paradrop_frameOld", diag_frameNo];
