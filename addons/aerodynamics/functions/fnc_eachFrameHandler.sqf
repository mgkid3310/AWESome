private _vehicle = vehicle player;
private _aerodynamicsEnabled = missionNamespace getVariable ["awesome_aerodynamics_enabled", false];
private _timeOld = missionNamespace getVariable ["awesome_aerodynamics_timeOld", -1];
private _frameOld = missionNamespace getVariable ["awesome_aerodynamics_frameOld", -1];

if (!_aerodynamicsEnabled || (_vehicle isEqualTo player) || (_timeOld < 0) || (_frameOld < 0)) exitWith {
    missionNamespace setVariable ["awesome_aerodynamics_timeOld", time];
    missionNamespace setVariable ["awesome_aerodynamics_frameOld", diag_frameNo];

    private _aeroConfigs = _vehicle getVariable ["awesome_aerodynamics_aeroConfig", false];
    if !(_aeroConfigs isEqualType []) then {
        _aeroConfigs = [_vehicle] call awesome_aerodynamics_fnc_getAeroConfig;
        _vehicle setVariable ["awesome_aerodynamics_aeroConfig", _aeroConfigs];
    };
    _vehicle setMass (_aeroConfigs select 3 select 1);
};
if (diag_frameNo < (_frameOld + awesome_aerodynamics_loopFrameInterval)) exitWith {};

if ((driver _vehicle isEqualTo player) && (_vehicle isKindOf "Plane")) then {
    [_vehicle, player, _timeOld] call awesome_aerodynamics_fnc_fixedWingLoop;
};

missionNamespace setVariable ["awesome_aerodynamics_timeOld", time];
missionNamespace setVariable ["awesome_aerodynamics_frameOld", diag_frameNo];
