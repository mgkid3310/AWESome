private _vehicle = vehicle player;
private _timeOld = missionNamespace getVariable ["orbis_cockpit_timeOld", -1];

if ((_vehicle isEqualTo player) || (_timeOld < 0)) exitWith {
    missionNamespace setVariable ["orbis_cockpit_timeOld", time];
};

if (_vehicle isKindOf "Plane") then {
    [_vehicle, player, _timeOld] call orbis_cockpit_fnc_headShakeLoop;
};

missionNamespace setVariable ["orbis_cockpit_timeOld", time];
