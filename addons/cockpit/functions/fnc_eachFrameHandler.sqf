private _vehicle = vehicle player;
private _timeOld = missionNamespace getVariable ["awesome_cockpit_timeOld", -1];

if ((_vehicle isEqualTo player) || (_timeOld < 0)) exitWith {
    missionNamespace setVariable ["awesome_cockpit_timeOld", time];
};

if (_vehicle isKindOf "Plane") then {
    [_vehicle, player, _timeOld] call awesome_cockpit_fnc_headShakeLoop;
};

missionNamespace setVariable ["awesome_cockpit_timeOld", time];
