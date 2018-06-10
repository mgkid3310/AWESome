private _modeGiven = _this select 0;
private _sound = _this select 1;
private _term = param [2, 0];

private _soundName = format ["%1_%2", _modeGiven, _sound];
private _length = getNumber (configFile >> "CfgSounds" >> _soundName >> "length");

private _isStop = (vehicle player) getVariable ["orbisGPWStestStop", false];
private _modeLocal = (vehicle player) getVariable ["orbisGPWSmodeLocal", ""];
if (!_isStop || !(_modeGiven isEqualTo _modeLocal)) then {
    private _crew = allPlayers select {_x in [driver vehicle player, gunner vehicle player, commander vehicle player]};
    private _targets = _crew select {_x getVariable ["hasOrbisATC", false]};

    private _volumeLow = (vehicle player) getVariable ["orbisGPWSvolumeLow", false];
    if (_volumeLow) then {
        _soundName = _soundName + "_low";
    };

    [_soundName] remoteExec ["playSound", _targets];

    sleep (_length + _term);
};
