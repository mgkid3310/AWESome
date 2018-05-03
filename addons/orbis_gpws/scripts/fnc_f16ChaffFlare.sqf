#include "header_macros.hpp"

DEV_CHAT("orbis_gpws: f16ChaffFlare run");
params ["_vehicle", "_weapon", "_muzzle", "_mode"];

if ((_weapon in orbis_gpws_ChaffFlareList) && !(_vehicle getVariable ["CMrunnig", false])) then {
	DEV_CHAT("orbis_gpws: f16ChaffFlare active");
	private _CMammoCount = 0;
	{
		_CMammoCount = _CMammoCount + (_x select 2);
	} forEach ((magazinesAllTurrets _vehicle) select {_x select 0 in getArray (configFile >> "CfgWeapons" >> _weapon >> "magazines")});
	private _ammosFired = (getNumber (configFile >> "CfgWeapons" >> _weapon >> _mode >> "burst")) * (getNumber (configFile >> "CfgWeapons" >> _weapon >> _mode >> "multiplier"));
	private _resultingAmmo = _CMammoCount - _ammosFired;

	if (_vehicle getVariable ["nextCMcount", _CMammoCount] < _CMammoCount) exitWith {};
	_vehicle setVariable ["nextCMcount", _resultingAmmo];
	_vehicle setVariable ["CMrunnig", true];

	DEV_CHAT("orbis_gpws: f16ChaffFlare waiting");
	waitUntil {(_vehicle getVariable ["orbisGPWSready", true]) || !((alive _vehicle) && (player in _vehicle))};

	if ((alive _vehicle) && (player in _vehicle)) then {
		switch (true) do {
			// f16_chaffFlareOut
			case (_resultingAmmo <= 0): {
				DEV_CHAT("orbis_gpws: f16_chaffFlareOut");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "f16_chaffFlareOut", 1.26] spawn orbis_gpws_fnc_speakGPWS;
			};

			// f16_chaffFlareLow
			case ((_resultingAmmo <= (_vehicle getVariable ["lowCMcount", _resultingAmmo - 1])) && !(_vehicle getVariable ["CMlowAlerted", false])): {
				DEV_CHAT("orbis_gpws: f16_chaffFlareLow");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "f16_chaffFlareLow", 1.34] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["CMlowAlerted", true];
			};

			// f16_chaffFlare
			default {
				DEV_CHAT("orbis_gpws: f16_chaffFlare");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "f16_chaffFlare", 0.86] spawn orbis_gpws_fnc_speakGPWS;
			};
		};
	};

	_vehicle setVariable ["CMrunnig", false];
};
