#include "script_component.hpp"

private _vehicle = param [0, vehicle player];
private _mode = param [1, 0];
private _ATISdata = missionNamespace getVariable [QGVAR(ATISdata), false];

if (GVAR(realtimeATIS)) then {
	_ATISdata = [false] call FUNC(updateATISdata);
};

if !(_ATISdata isEqualType []) exitWith {};

private _crew = allPlayers select {[_x, _vehicle, _mode] call EFUNC(main,isCrew)};
private _targets = _crew select {_x getVariable [QGVAR(hasAWESomeATC), false]};

[QGVAR(speakATIS), [_vehicle, _ATISdata, _mode], _targets] call CBA_fnc_targetEvent;
