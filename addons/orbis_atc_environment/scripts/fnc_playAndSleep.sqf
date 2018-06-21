private _sound = _this select 0;
private _length = getNumber (configFile >> "CfgSounds" >> _sound >> "length");

if ((vehicle player) getVariable ["orbisATISstop", false]) exitWith {};

private _crew = allPlayers select {[_x, vehicle player] call orbis_awesome_main_fnc_isCrew};
private _targets = _crew select {_x getVariable ["hasOrbisATC", false]};

[_sound] remoteExec ["playSound", _targets];

sleep _length;
