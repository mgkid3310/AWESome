#include "script_component.hpp"

private _sound = param [0, ""];
private _vehicle = param [1, vehicle player];
private _standard = param [2, 0.3];

if (_sound isEqualTo "") exitWith {};
if (!(_vehicle isEqualType objNull) || (isNull _vehicle)) exitWith {playSound _sound};

private _insideSoundCoef = getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "insideSoundCoef");
// private _multiplier = 10 * (_standard / _insideSoundCoef);
private _multiplier = 10 * ([_standard, _insideSoundCoef] call orbis_temp);
private _count = 1 max (round _multiplier) min 30;
systemChat str [_multiplier, _count];
for "_i" from 1 to _count do {
	playSound _sound;
};
