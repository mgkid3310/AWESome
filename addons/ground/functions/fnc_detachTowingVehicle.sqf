#include "script_component.hpp"

params ["_car"];

private _towingPlayer = _car getVariable [QGVAR(towingPlayer), objNull];
if (!(isNull _towingPlayer) && !(local _towingPlayer)) exitWith {
	[QGVAR(detachTowingVehicle), [_car], _towingPlayer] call CBA_fnc_targetEvent;
};

if ((player getVariable [QGVAR(towVehicle), objNull]) isEqualTo _car) then {
	if (GVAR(towingEventID) >= 0) then {
		removeMissionEventHandler ["EachFrame", GVAR(towingEventID)];
		GVAR(towingEventID) = -1;
	};
	player setVariable [QGVAR(towVehicle), nil, true];
};

private _plane = _car getVariable [QGVAR(towingTarget), objNull];
private _towBar = _car getVariable [QGVAR(towBarObject), objNull];
_plane allowDamage true;
_car enableCollisionWith _plane;
_towBar enableCollisionWith _plane;
if !(local _plane) then {
	[_plane, true] remoteExec ["allowDamage", _plane];
	[_car, _plane] remoteExec ["enableCollisionWith", _plane];
	[_towBar, _plane] remoteExec ["enableCollisionWith", _plane];
};

_car setVariable [QGVAR(towingPlayer), nil, true];
_car setVariable [QGVAR(isTowingPlane), false, true];
_car setVariable [QGVAR(towingTarget), nil, true];
_car setVariable [QGVAR(towingCollisionTime), nil];

_car setVariable [QGVAR(offsetOldArray), nil, true];
_car setVariable [QGVAR(posBarOld), nil, true];
_car setVariable [QGVAR(towingPosRelCar), nil, true];
_car setVariable [QGVAR(towingPosRelPlane), nil, true];
_car setVariable [QGVAR(towingRotateCenter), nil, true];
_car setVariable [QGVAR(towingTimeOld), nil, true];
_car setVariable [QGVAR(towingFrameOld), nil, true];
