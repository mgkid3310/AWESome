#include "script_component.hpp"

params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

if ((_ammo isKindOf ["MissileCore", configFile >> "CfgAmmo"]) || (_ammo isKindOf ["BombCore", configFile >> "CfgAmmo"])) then {
	private _additionalPlanes = missionNameSpace getVariable [QGVAR(additionalPlanes), []];
	private _additionalHelies = missionNameSpace getVariable [QGVAR(additionalHelies), []];
	private _additionalSAMs = missionNameSpace getVariable [QGVAR(additionalSAMs), []];

	private _trackedWeapons = missionNamespace getVariable [QGVAR(trackedWeapons), []];
	_trackedWeapons pushBack [_projectile, _weapon, side driver _unit, _unit in (_additionalPlanes + _additionalHelies + _additionalSAMs)];
	missionNamespace setVariable [QGVAR(trackedWeapons), _trackedWeapons];
};
