private _vehicle = vehicle player;
private _timeOld = missionNamespace getVariable ["orbis_aerodynamics_timeOld", -1];
private _frameOld = missionNamespace getVariable ["orbis_aerodynamics_frameOld", -1];

if (!orbis_aerodynamics_enabled || (_vehicle isEqualTo player) || (_timeOld < 0) || (_frameOld < 0)) exitWith {
    missionNamespace setVariable ["orbis_aerodynamics_timeOld", time];
    missionNamespace setVariable ["orbis_aerodynamics_frameOld", diag_frameNo];

    private _aeroConfigs = _vehicle getVariable ["orbis_aerodynamics_aeroConfig", false];
    if !(_aeroConfigs isEqualType []) then {
        _aeroConfigs = [_vehicle] call orbis_aerodynamics_fnc_getAeroConfig;
        _vehicle setVariable ["orbis_aerodynamics_aeroConfig", _aeroConfigs];
    };
    _vehicle setMass (_aeroConfigs select 3 select 1);
};
if (diag_frameNo < (_frameOld + orbis_aerodynamics_loopFrameInterval)) exitWith {};

if ((driver _vehicle isEqualTo player) && (_vehicle isKindOf "Plane")) then {
    [_vehicle, player, _timeOld] call orbis_aerodynamics_fnc_fixedWingLoop;
};

missionNamespace setVariable ["orbis_aerodynamics_timeOld", time];
missionNamespace setVariable ["orbis_aerodynamics_frameOld", diag_frameNo];
