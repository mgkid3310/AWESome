#include "script_component.hpp"

params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

if ((_ammo isKindOf ["MissileCore", configFile >> "CfgAmmo"]) || (_ammo isKindOf ["BombCore", configFile >> "CfgAmmo"])) then {
	private _trackedWeapons = missionNamespace getVariable [QGVAR(trackedWeapons), []];
	_trackedWeapons pushBack [_projectile, _weapon, side driver _unit];
	missionNamespace setVariable [QGVAR(trackedWeapons), _trackedWeapons];
};
