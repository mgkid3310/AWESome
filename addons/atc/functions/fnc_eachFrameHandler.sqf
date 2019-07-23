#include "script_component.hpp"

private _timeOld = missionNamespace getVariable [QGVAR(timeOld), -1];
private _frameOld = missionNamespace getVariable [QGVAR(frameOld), -1];

if (!(alive player) || (_timeOld < 0) || (_frameOld < 0)) exitWith {
	missionNamespace setVariable [QGVAR(timeOld), time];
	missionNamespace setVariable [QGVAR(frameOld), diag_frameNo];
};

private _planes = (entities "Plane") select {alive _x};
private _helies = (entities "Helicopter") select {alive _x};
private _SAMlaunchers = [];
{
	_planes pushBackUnique _x;
} forEach (missionNameSpace getVariable [QGVAR(additionalPlanes), []]);
{
	_helies pushBackUnique _x;
} forEach (missionNameSpace getVariable [QGVAR(additionalHelies), []]);
{
	_SAMlaunchers pushBackUnique _x;
} forEach (missionNameSpace getVariable [QGVAR(additionalSAMs), []]);

// eventHandler
{
	_x setVariable [QGVAR(eventWeaponFire), _x addEventHandler ["Fired", {_this spawn FUNC(eventWeaponFire)}]];
} forEach ((_planes + _helies + _SAMlaunchers) select {_x getVariable [QGVAR(eventWeaponFire), -1] < 0});

// save recorded data
if (missionNamespace getVariable [QGVAR(endRecordingRadar), false]) then {
	private _replayData = missionNamespace getVariable [QGVAR(radarReplayData), []];
	_replayData pushBack (missionNamespace getVariable [QGVAR(radarRecordData), [time]]);
	missionNamespace setVariable [QGVAR(radarReplayData), _replayData, true];

	missionNamespace setVariable [QGVAR(isRecordingRadar), false];
	missionNamespace setVariable [QGVAR(endRecordingRadar), false];
	missionNamespace setVariable [QGVAR(radarRecordData), false];
};

// date replay data
if (missionNamespace getVariable [QGVAR(isRecordingRadar), false]) then {
	private _array = missionNamespace getVariable [QGVAR(radarRecordData), false];
	if !(_array isEqualType []) then {
		_array = [time];
	};

	private _planesAuto = [_planes] call FUNC(getAutoTransponders);
	private _heliesAuto = [_helies] call FUNC(getAutoTransponders);
	private _planesManual = _planes - _planesAuto;
	private _heliesManual = _helies - _heliesAuto;

	private _planesModeC = _planesManual select {_x getVariable [QEGVAR(gpws,transponderMode), 0] isEqualTo 2};
	private _heliesModeC = _heliesManual select {_x getVariable [QEGVAR(gpws,transponderMode), 0] isEqualTo 2};
	private _planesStandBy = _planesManual select {_x getVariable [QEGVAR(gpws,transponderMode), 0] isEqualTo 1};
	private _heliesStandBy = _heliesManual select {_x getVariable [QEGVAR(gpws,transponderMode), 0] isEqualTo 1};

	_planesModeC = _planesModeC + (_planesAuto select {(isEngineOn _x) && (!isTouchingGround _x)});
	_heliesModeC = _heliesModeC + (_heliesAuto select {(isEngineOn _x) && (!isTouchingGround _x)});
	_planesStandBy = _planesStandBy + (_planesAuto select {(isEngineOn _x) && (isTouchingGround _x)});
	_heliesStandBy = _heliesStandBy + (_heliesAuto select {(isEngineOn _x) && (isTouchingGround _x)});

	private _trackedWeapons = missionNamespace getVariable [QGVAR(trackedWeapons), []];
	private _weaponObjects = _trackedWeapons apply {_x select 0};

	{
		_x setVariable [QGVAR(replayID), format ["%1_%2", time, _forEachIndex]];
	} forEach ((_planesModeC + _heliesModeC + _planesStandBy + _heliesStandBy + _weaponObjects) select {_x getVariable [QGVAR(replayID), ""] isEqualTo ""});

	private _data = [time];
	_data append (_planesModeC apply {[
		_x getVariable [QGVAR(replayID), ""],
		0,
		3.6 * vectorMagnitude velocity _x,
		getPosASL _x select 2,
		velocity _x select 2,
		round direction _x,
		getPos _x,
		[name driver _x, groupId group driver _x, _x getVariable [QGVAR(customCallsign), groupId group driver _x]],
		side driver _x
	]});
	_data append (_heliesModeC apply {[
		_x getVariable [QGVAR(replayID), ""],
		1,
		3.6 * vectorMagnitude velocity _x,
		getPosASL _x select 2,
		velocity _x select 2,
		round direction _x,
		getPos _x,
		[name driver _x, groupId group driver _x, _x getVariable [QGVAR(customCallsign), groupId group driver _x]],
		side driver _x
	]});
	_data append (_planesStandBy apply {[
		_x getVariable [QGVAR(replayID), ""],
		2,
		3.6 * vectorMagnitude velocity _x,
		getPosASL _x select 2,
		velocity _x select 2,
		round direction _x,
		getPos _x,
		[name driver _x, groupId group driver _x, _x getVariable [QGVAR(customCallsign), groupId group driver _x]],
		side driver _x
	]});
	_data append (_heliesStandBy apply {[
		_x getVariable [QGVAR(replayID), ""],
		3,
		3.6 * vectorMagnitude velocity _x,
		getPosASL _x select 2,
		velocity _x select 2,
		round direction _x,
		getPos _x,
		[name driver _x, groupId group driver _x, _x getVariable [QGVAR(customCallsign), groupId group driver _x]],
		side driver _x
	]});
	_data append (_trackedWeapons apply {[
		(_x select 0) getVariable [QGVAR(replayID), ""],
		4,
		3.6 * vectorMagnitude velocity (_x select 0),
		getPosASL (_x select 0) select 2,
		velocity (_x select 0) select 2,
		round direction (_x select 0),
		getPos (_x select 0),
		[getText (configFile >> "CfgWeapons" >> (_x select 1) >> "displayName")],
		_x select 2
	]});
	_array pushBack _data;

	missionNamespace setVariable [QGVAR(radarRecordData), _array];
};

// call radar/replay functions
private _isUsingRadar = player getVariable [QGVAR(isUsingRadar), false];
private _isUsingReplay = player getVariable [QGVAR(isUsingReplay), false];
private _radarParam = player getVariable [QGVAR(radarParam), []];
private _replayParam = player getVariable [QGVAR(replayParam), []];

if (_isUsingReplay) then {
	_replayParam call FUNC(atcReplayLoop);
	player setVariable [QGVAR(exitRadar), true];
};

if (_isUsingRadar) then {
	_radarParam call FUNC(atcRadarLoop);
};

[] call FUNC(periodicCheck);

missionNamespace setVariable [QGVAR(timeOld), time];
missionNamespace setVariable [QGVAR(frameOld), diag_frameNo];
