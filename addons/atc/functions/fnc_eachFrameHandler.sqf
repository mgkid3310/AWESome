#include "script_component.hpp"

private _timeOld = missionNamespace getVariable [QGVAR(timeOld), -1];
private _frameOld = missionNamespace getVariable [QGVAR(frameOld), -1];

if (!(alive player) || (_timeOld < 0) || (_frameOld < 0)) exitWith {
	missionNamespace setVariable [QGVAR(timeOld), time];
	missionNamespace setVariable [QGVAR(frameOld), diag_frameNo];
};

// update callsign to server
if !((player getVariable [QGVAR(personalCallsign), name player]) isEqualTo GVAR(personalCallsign)) then {
	player setVariable [QGVAR(personalCallsign), GVAR(personalCallsign), true];
};

// track radar entities
private _planes = (entities "Plane") select {alive _x};
private _helies = (entities "Helicopter") select {alive _x};
private _SAMlaunchers = [];
{
	_planes pushBackUnique _x;
} forEach (missionNamespace getVariable [QGVAR(additionalPlanes), []]);
{
	_helies pushBackUnique _x;
} forEach (missionNamespace getVariable [QGVAR(additionalHelies), []]);
{
	_SAMlaunchers pushBackUnique _x;
} forEach (missionNamespace getVariable [QGVAR(additionalSAMs), []]);

// add Eventhandlers
{
	_x setVariable [QGVAR(eventWeaponFire), _x addEventHandler ["Fired", {_this spawn FUNC(eventWeaponFire)}]];
} forEach ((_planes + _helies + _SAMlaunchers) select {_x getVariable [QGVAR(eventWeaponFire), -1] < 0});

// call radar functions
private _isUsingRadar = player getVariable [QGVAR(isUsingRadar), false];
private _radarParam = player getVariable [QGVAR(radarParam), []];

if (_isUsingRadar) then {
	_radarParam call FUNC(atcRadarLoop);
};

[] call FUNC(periodicCheck);

// ATIS status check
private _isATISready = (vehicle player) getVariable [QGVAR(isATISready), true];
private _lastTime = (vehicle player) getVariable [QGVAR(lastATIStime), CBA_missionTime];
if (!_isATISready && (CBA_missionTime > (_lastTime + 60))) then {
	(vehicle player) setVariable [QGVAR(isATISready), true, true];
};

// ATIS data update check
if (GVAR(updateIntervalATIS) > 0) then {
	private _ATISdata = missionNamespace getVariable [QGVAR(ATISdata), false];
	if !(_ATISdata isEqualType []) then {
		[true, true] call FUNC(updateATISdata);
	} else {
		if (CBA_missionTime > (_ATISdata select 0 select 1) + GVAR(updateIntervalATIS) * 60) then {
			[true, true] call FUNC(updateATISdata);
		};
	};
};

missionNamespace setVariable [QGVAR(timeOld), time];
missionNamespace setVariable [QGVAR(frameOld), diag_frameNo];
