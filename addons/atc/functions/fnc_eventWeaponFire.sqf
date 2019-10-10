#include "script_component.hpp"

params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

if ((_ammo isKindOf ["MissileCore", configFile >> "CfgAmmo"]) || (_ammo isKindOf ["BombCore", configFile >> "CfgAmmo"])) then {
	private _monitoringVehicles = [];

	if (player getVariable [QGVAR(isUsingRadar), false]) then {
		_monitoringVehicles = missionNameSpace getVariable [QGVAR(monitoringVehicles), []];
	} else {
		private _additionalPlanes = missionNameSpace getVariable [QGVAR(additionalPlanes), []];
		private _additionalHelies = missionNameSpace getVariable [QGVAR(additionalHelies), []];
		private _additionalSAMs = missionNameSpace getVariable [QGVAR(additionalSAMs), []];

		_monitoringVehicles = _additionalPlanes + _additionalHelies + _additionalSAMs;
	};

	private _targetPos = getPos missileTarget _projectile;
	private _isHostileTo = _unit getVariable [QGVAR(isHostileTo), []];
	{
		_isHostileTo pushBackUnique (side _x);
	} forEach (_targetPos nearEntities 5);
	_unit setVariable [QGVAR(isHostileTo), _isHostileTo];

	private _trackedWeapons = missionNamespace getVariable [QGVAR(trackedWeapons), []];
	_trackedWeapons pushBack [_projectile, _weapon, _unit, side driver _unit, _unit in _monitoringVehicles];
	missionNamespace setVariable [QGVAR(trackedWeapons), _trackedWeapons];
};
