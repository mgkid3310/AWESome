#include "script_component.hpp"
#include "header_macros.hpp"

DEV_CHAT("orbis_gpws: f16ChaffFlare run");
params ["_vehicle", "_weapon", "_muzzle", "_mode"];

if ((_weapon in GVAR(ChaffFlareList)) && !(_vehicle getVariable [QGVAR(CMrunning), false])) then {
	DEV_CHAT("orbis_gpws: f16ChaffFlare active");
	private _CMammoCount = 0;
	{
		_CMammoCount = _CMammoCount + (_x select 2);
	} forEach ((magazinesAllTurrets _vehicle) select {_x select 0 in getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines")});
	private _ammosFired = (getNumber (configFile >> "CfgWeapons" >> _weapon >> _mode >> "burst")) * (getNumber (configFile >> "CfgWeapons" >> _weapon >> _mode >> "multiplier"));
	private _resultingAmmo = _CMammoCount - _ammosFired;
	private _lowCMcount = getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> QGVAR(lowCMcount));

	if (_vehicle getVariable [QGVAR(nextCMcount), _CMammoCount] < _CMammoCount) exitWith {};
	_vehicle setVariable [QGVAR(nextCMcount), _resultingAmmo];
	_vehicle setVariable [QGVAR(CMrunning), true];

	DEV_CHAT("orbis_gpws: f16ChaffFlare waiting");
	waitUntil {((_vehicle getVariable [QGVAR(isGPWSready), -1]) < time) || !((alive _vehicle) && (player in _vehicle))};

	if ((alive _vehicle) && (player in _vehicle)) then {
		switch (true) do {
			// f16_chaffFlareOut
			case (_resultingAmmo <= 0): {
				DEV_CHAT("orbis_gpws: f16_chaffFlareOut");
				[_vehicle, "f16_chaffFlareOut"] call FUNC(speakGPWS);
			};

			// f16_chaffFlareLow
			case ((_resultingAmmo <= _lowCMcount) && !(_vehicle getVariable [QGVAR(lowCMalerted), false])): {
				DEV_CHAT("orbis_gpws: f16_chaffFlareLow");
				[_vehicle, "f16_chaffFlareLow"] call FUNC(speakGPWS);
				_vehicle setVariable [QGVAR(lowCMalerted), true];
			};

			// f16_chaffFlare
			default {
				DEV_CHAT("orbis_gpws: f16_chaffFlare");
				[_vehicle, "f16_chaffFlare"] call FUNC(speakGPWS);
			};
		};
	};

	_vehicle setVariable [QGVAR(CMrunning), false];
};
