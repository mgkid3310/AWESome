#include "script_component.hpp"

private _sound = _this select 0;
private _length = getNumber (configFile >> "CfgSounds" >> _sound >> "length");

if ((vehicle player) getVariable [QGVAR(stopATIS), false]) exitWith {};

private _crew = allPlayers select {[_x, vehicle player] call EFUNC(main,isCrew)};
private _targets = _crew select {_x getVariable [QGVAR(hasAWESomeATC), false]};

[_sound] remoteExec ["playSound", _targets];

sleep _length;
