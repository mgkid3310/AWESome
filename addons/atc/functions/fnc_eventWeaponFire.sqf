#include "script_component.hpp"

params ["_unit", "_weapon", "_muzzle", "_mode", "_ammo", "_magazine", "_projectile", "_gunner"];

diag_log str _this;

if (true) then {
	private _trackedWeapons = missionNamespace getVariable [QGVAR(trackedWeapons), []];
	_trackedWeapons pushBack [_projectile, _weapon, side driver _unit];
	missionNamespace setVariable [QGVAR(trackedWeapons), _trackedWeapons];
};
