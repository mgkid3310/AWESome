#include "script_component.hpp"

private _ATISdata = missionNamespace getVariable [QGVAR(ATISdata), false];

if (GVAR(realtimeATIS)) then {
	_ATISdata = [false] call FUNC(updateATISdata);
};

if !(_ATISdata isEqualType []) exitWith {};
_ATISdata spawn FUNC(speakATIS);
