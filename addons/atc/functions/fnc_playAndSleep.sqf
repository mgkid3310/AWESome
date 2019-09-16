#include "script_component.hpp"

private _vehicle = param [0, vehicle player];
private _sound = param [1, ""];
private _mode = param [2, 0];
private _length = getNumber (configFile >> "CfgSounds" >> _sound >> "length");

if (_vehicle getVariable [QGVAR(stopATIS), false]) exitWith {};
if !([player, _vehicle, _mode] call EFUNC(main,isCrew)) exitWith {sleep _length};

private _crew = allPlayers select {[_x, vehicle player] call EFUNC(main,isCrew)};
private _targets = _crew select {_x getVariable [QGVAR(hasAWESomeATC), false]};

[_sound] remoteExec ["playSound", _targets];

sleep _length;
