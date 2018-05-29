private _sound = _this select 0;
private _length = getNumber (configFile >> "CfgSounds" >> _sound >> "length");

[_sound] remoteExec ["playSound", allPlayers in [driver vehicle player, gunner vehicle player, commander vehicle player]];
sleep _length;
