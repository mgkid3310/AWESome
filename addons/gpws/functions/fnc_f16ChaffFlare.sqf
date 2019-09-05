#include "script_component.hpp"
#include "header_macros.hpp"

DEV_CHAT("orbis_gpws: f16ChaffFlare run");
params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

if ((_weapon in GVAR(ChaffFlareList)) && !(_unit getVariable [QGVAR(CMrunning), false])) then {
	DEV_CHAT("orbis_gpws: f16ChaffFlare active");
	private _CMammoCount = 0;
	{
		_CMammoCount = _CMammoCount + (_x select 2);
	} forEach ((magazinesAllTurrets _unit) select {_x select 0 in getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines")});
	private _ammosFired = (getNumber (configFile >> "CfgWeapons" >> _weapon >> _mode >> "burst")) * (getNumber (configFile >> "CfgWeapons" >> _weapon >> _mode >> "multiplier"));
	private _resultingAmmo = _CMammoCount - _ammosFired;
	private _lowCMcount = getNumber (configFile >> "CfgVehicles" >> (typeOf _unit) >> QGVAR(lowCMcount));

	if (_unit getVariable [QGVAR(nextCMcount), _CMammoCount] < _CMammoCount) exitWith {};
	_unit setVariable [QGVAR(nextCMcount), _resultingAmmo];
	_unit setVariable [QGVAR(CMrunning), true];

	DEV_CHAT("orbis_gpws: f16ChaffFlare waiting");
	waitUntil {((_unit getVariable [QGVAR(nextGPWStime), -1]) < time) || !((alive _unit) && (player in _unit))};

	if ((alive _unit) && (player in _unit)) then {
		switch (true) do {
			// f16_chaffFlareOut
			case (_resultingAmmo <= 0): {
				DEV_CHAT("orbis_gpws: f16_chaffFlareOut");
				[_unit, "f16_chaffFlareOut"] call FUNC(speakGPWS);
			};

			// f16_chaffFlareLow
			case ((_resultingAmmo <= _lowCMcount) && !(_unit getVariable [QGVAR(lowCMalerted), false])): {
				DEV_CHAT("orbis_gpws: f16_chaffFlareLow");
				[_unit, "f16_chaffFlareLow"] call FUNC(speakGPWS);
				_unit setVariable [QGVAR(lowCMalerted), true];
			};

			// f16_chaffFlare
			default {
				DEV_CHAT("orbis_gpws: f16_chaffFlare");
				[_unit, "f16_chaffFlare"] call FUNC(speakGPWS);
			};
		};
	};

	_unit setVariable [QGVAR(CMrunning), false];
};
