private _sound = _this select 0;
private _length = getNumber (configFile >> "CfgSounds" >> _sound >> "length");

["orbisPlaySoundATIS", [vehicle player, _sound]] call CBA_fnc_globalEvent;
sleep _length;
