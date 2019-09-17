#include "script_component.hpp"

private _modeGiven = _this select 0;
private _sound = _this select 1;
private _term = param [2, 0];

private _soundName = format ["%1_%2", _modeGiven, _sound];
private _length = getNumber (configFile >> "CfgSounds" >> _soundName >> "length");

private _isStop = (vehicle player) getVariable [QGVAR(GPWStestStop), false];
private _modeLocal = (vehicle player) getVariable [QGVAR(GPWSmodeLocal), "off"];
if (!_isStop && (_modeGiven isEqualTo _modeLocal)) then {
	private _volumeLow = (vehicle player) getVariable [QGVAR(GPWSvolumeLow), false];
	if (_volumeLow) then {
		_soundName = _soundName + "_low";
	};

	private _crew = allPlayers select {[_x, vehicle player, 1] call EFUNC(main,isCrew)};
	private _targets = _crew select {_x getVariable [QGVAR(hasAWESomeGPWS), false]};

	[QEGVAR(main,playSoundVehicle), [_soundName], _targets] call CBA_fnc_targetEvent;

	sleep (_length + _term);
};
