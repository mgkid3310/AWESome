#include "script_component.hpp"

params [["_sound", ""], ["_vehicle", vehicle player], ["_standard", 0.3]];

if (_sound isEqualTo "") exitWith {};

/* if (!(_vehicle isEqualType objNull) || (isNull _vehicle)) exitWith {playSound _sound};

private _insideSoundCoef = getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "insideSoundCoef");
private _multiplier = 10 * _standard / _insideSoundCoef;
private _count = 1 max (round _multiplier) min 30;
systemChat str [_multiplier, _count];

for "_i" from 1 to _count do {
	playSound _sound;
}; */

playSound _sound;
