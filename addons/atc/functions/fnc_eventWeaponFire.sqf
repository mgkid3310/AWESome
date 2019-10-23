#include "script_component.hpp"

params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

if ((_ammo isKindOf ["MissileCore", configFile >> "CfgAmmo"]) || (_ammo isKindOf ["BombCore", configFile >> "CfgAmmo"])) then {
	private _targetPos = ASLToAGL getPosASL missileTarget _projectile;
	private _isHostileTo = _unit getVariable [QGVAR(isHostileTo), []];
	{
		_isHostileTo pushBackUnique (side _x);
	} forEach (_targetPos nearEntities 5);
	_unit setVariable [QGVAR(isHostileTo), _isHostileTo];

	private _trackedWeapons = missionNamespace getVariable [QGVAR(trackedWeapons), []];
	_trackedWeapons pushBack [_projectile, _weapon, side driver _unit, _isHostileTo];
	missionNamespace setVariable [QGVAR(trackedWeapons), _trackedWeapons];
};
