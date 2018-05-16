private _sound = _this select 0;
private _term = param [1, 0];
private _length = getNumber (configFile >> "CfgSounds" >> _sound >> "length");

playSound _sound;
sleep (_length + _term);
