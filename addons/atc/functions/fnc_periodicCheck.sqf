#include "script_component.hpp"

private _additionalPlanes = missionNamespace getVariable [QGVAR(additionalPlanes), []];
_additionalPlanes = _additionalPlanes select {alive _x};
missionNamespace setVariable [QGVAR(additionalPlanes), _additionalPlanes];

private _additionalHelies = missionNamespace getVariable [QGVAR(additionalHelies), []];
_additionalHelies = _additionalHelies select {alive _x};
missionNamespace setVariable [QGVAR(additionalHelies), _additionalHelies];

private _additionalSAMs = missionNamespace getVariable [QGVAR(additionalSAMs), []];
_additionalSAMs = _additionalSAMs select {alive _x};
missionNamespace setVariable [QGVAR(additionalSAMs), _additionalSAMs];

private _trackedWeapons = missionNamespace getVariable [QGVAR(trackedWeapons), []];
_trackedWeapons = _trackedWeapons select {(alive (_x select 0)) && (getPos (_x select 0) select 2 > 1)};
missionNamespace setVariable [QGVAR(trackedWeapons), _trackedWeapons];
