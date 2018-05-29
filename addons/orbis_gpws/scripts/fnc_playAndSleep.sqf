private _sound = _this select 0;
private _term = param [1, 0];
private _length = getNumber (configFile >> "CfgSounds" >> _sound >> "length");

private _crew = allPlayers select {_x in [driver vehicle player, gunner vehicle player, commander vehicle player]};
private _targets = _crew select {!(local _x) && (_x getVariable ["hasOrbisATC", false])};

playSound _sound;
[_sound] remoteExec ["playSound", _targets];

sleep (_length + _term);
