private _vehicle = vehicle player;
private _aerodynamicsEnabled = missionNamespace getVariable ["orbis_aerodynamics_enabled", false];
private _timeOld = missionNamespace getVariable ["orbis_aerodynamics_timeOld", -1];
private _frameOld = missionNamespace getVariable ["orbis_aerodynamics_frameOld", -1];

if (!_aerodynamicsEnabled || (_vehicle isEqualTo player) || (_timeOld < 0) || (_frameOld < 0)) exitWith {};
if (diag_frameNo < (_frameOld + orbis_aerodynamics_loopFrameInterval)) exitWith {};

if (_vehicle isKindOf "Plane") then {
    [_vehicle, player, _timeOld] call orbis_aerodynamics_fnc_fixedWingLoop;
};

missionNamespace setVariable ["orbis_aerodynamics_timeOld", time];
missionNamespace getVariable ["orbis_aerodynamics_frameOld", diag_frameNo];
