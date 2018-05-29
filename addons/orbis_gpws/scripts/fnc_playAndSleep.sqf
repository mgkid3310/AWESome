private _sound = _this select 0;
private _term = param [1, 0];
private _length = getNumber (configFile >> "CfgSounds" >> _sound >> "length");

["orbisPlaySoundGPWS", [vehicle player, _sound]] call CBA_fnc_globalEvent;
sleep (_length + _term);
