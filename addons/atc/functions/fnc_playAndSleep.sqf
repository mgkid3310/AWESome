#include "script_component.hpp"

params [["_vehicle", vehicle player], ["_sound", ""], ["_mode", 0], ["_noSound", False], ["_text", 0], ["_addSpace", True]];

private _length = getNumber (configFile >> "CfgSounds" >> _sound >> "length");

if (_vehicle getVariable [QGVAR(stopATIS), false]) exitWith {_text};
if !([player, _vehicle, _mode] call EFUNC(main,isCrew)) exitWith {
	sleep _length;
	_text
};

if !(_noSound) then {
	[QEGVAR(main,playSoundVehicle), [_sound]] call CBA_fnc_localEvent;
	sleep _length;
};

if (_text isEqualType "") then {
	_dec = getText (configFile >> "CfgSounds" >> _sound >> "text_dec");
	_text = _text + _dec;
	if (_addSpace && (_dec != "")) then {
		_text = _text + " ";
	};
};

_text
