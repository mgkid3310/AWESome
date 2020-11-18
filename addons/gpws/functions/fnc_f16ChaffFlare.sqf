#include "script_component.hpp"
#include "header_macros.hpp"

params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];
DEV_CHAT("orbis_gpws: f16ChaffFlare run");

if !(_weapon in GVAR(ChaffFlareList)) exitWith {};
DEV_CHAT("orbis_gpws: f16ChaffFlare active");

private _burstNumber = getNumber (configFile >> "CfgWeapons" >> _weapon >> _mode >> "burst");
private _multiplier = getNumber (configFile >> "CfgWeapons" >> _weapon >> _mode >> "multiplier");
private _ammosFired = _burstNumber * _multiplier;

if ((typeOf _unit) in ["JS_JC_FA18E", "JS_JC_FA18F"]) then {
	if (_weapon == "js_w_fa18_CMFlareLauncher") then {
		_ammosFired = _ammosFired * (_unit getVariable ["js_jc_fa18_ew_flareNum", js_jc_fa18_ew_flareNum]);
	};
	if (_weapon == "js_w_fa18_CMChaffLauncher") then {
		_ammosFired = _ammosFired * (_unit getVariable ["js_jc_fa18_ew_chaffNum", js_jc_fa18_ew_chaffNum]);
	};
	_ammosFired = _ammosFired * (_unit getVariable ["js_jc_fa18_ew_CMRpt", js_jc_fa18_ew_CMRpt];
};

private _weaponState = weaponState [_unit, [-1], _weapon];
private _CMammoCount = (_weaponState select 4) + _multiplier;

private _nextCMcountArray = _unit getVariable [QGVAR(nextCMcountArray), []];
private _weaponCMarray = _nextCMcountArray select {_x select 0 == _weapon};
private _nextCMarray = [[_weapon, _mode, _CMammoCount, _CMammoCount], _weaponCMarray select 0] select (count _weaponCMarray > 0);
_nextCMarray params ["_weaponOld", "_modeOld", "_nextCMcount", "_CMammoCountOld"];

private _fullMagAmmo = getNumber (configFile >> "CfgMagazines" >> (_weaponState select 3) >> "count");
if (!(_CMammoCount < _CMammoCountOld) && !(_CMammoCount > _fullMagAmmo)) then {_nextCMcount = _CMammoCount}; // fire on new shot after reload
if ((_modeOld == _mode) && (_burstNumber != 1) && (_nextCMcount < _CMammoCount)) exitWith {}; // fire if mode has been changed / single burst mode

private _resultingAmmo = [_CMammoCount - _ammosFired, -1] select ((_burstNumber == 1) && (_CMammoCount > _fullMagAmmo));
private _lowCMcount = getNumber (configFile >> "CfgVehicles" >> (typeOf _unit) >> QGVAR(lowCMcount));
private _lowCMalerted = _unit getVariable [QGVAR(lowCMalerted), []];
if ((_resultingAmmo > _lowCMcount) && (_weapon in _lowCMalerted)) then {
	_lowCMalerted = _lowCMalerted - [_weapon];
	_unit setVariable [QGVAR(lowCMalerted), _lowCMalerted];
};

_nextCMcountArray = _nextCMcountArray - _weaponCMarray;
_nextCMcountArray pushBack [_weapon, _mode, _resultingAmmo, _CMammoCount];
_unit setVariable [QGVAR(nextCMcountArray), _nextCMcountArray];

if !((alive _unit) && ((_unit getVariable [QGVAR(GPWSmodeLocal), "off"]) == "f16") && ([player, _unit, 1] call EFUNC(main,isCrew))) exitWith {};
if ((_unit getVariable [QGVAR(lastChaffFlaretime), -1]) + 0.86 > time) exitWith {};

DEV_CHAT("orbis_gpws: f16ChaffFlare waiting");
waitUntil {(_unit getVariable [QGVAR(nextGPWStime), -1]) < time};

if ((alive _unit) && ((_unit getVariable [QGVAR(GPWSmodeLocal), "off"]) == "f16") && ([player, _unit, 1] call EFUNC(main,isCrew))) then {
	switch (true) do {
		// f16_chaffFlareOut
		case (_resultingAmmo <= 0): {
			DEV_CHAT("orbis_gpws: f16_chaffFlareOut");
			[_unit, "f16_chaffFlareOut"] call FUNC(speakGPWS);
			_unit setVariable [QGVAR(lastChaffFlaretime), time];
		};

		// f16_chaffFlareLow
		case ((_resultingAmmo <= _lowCMcount) && !(_weapon in _lowCMalerted)): {
			DEV_CHAT("orbis_gpws: f16_chaffFlareLow");
			[_unit, "f16_chaffFlareLow"] call FUNC(speakGPWS);
			_unit setVariable [QGVAR(lastChaffFlaretime), time];
			_unit setVariable [QGVAR(lowCMalerted), _lowCMalerted + [_weapon]];
		};

		// f16_chaffFlare
		default {
			DEV_CHAT("orbis_gpws: f16_chaffFlare");
			[_unit, "f16_chaffFlare"] call FUNC(speakGPWS);
			_unit setVariable [QGVAR(lastChaffFlaretime), time];
		};
	};
};
