private _sound = _this select 0;
private _term = param [1, 0];
private _length = getNumber (configFile >> "CfgSounds" >> _sound >> "length");

private _isStop = (vehicle player) getVariable ["orbisGPWStestStop", false];
if !(_isStop) then {
    private _crew = allPlayers select {_x in [driver vehicle player, gunner vehicle player, commander vehicle player]};
    private _targets = _crew select {_x getVariable ["hasOrbisATC", false]};

    private _volumeLow = (vehicle player) getVariable ["orbisGPWSvolumeLow", false];
    if (_volumeLow) then {
        _sound = format ["%1_low", _sound];
    };

    [_sound] remoteExec ["playSound", _targets];

    sleep (_length + _term);
};
