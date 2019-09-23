#include "script_component.hpp"

params ["_vehicle", ["_dynamicWindMode", GVAR(dynamicWindMode)]];

if !(_dynamicWindMode > 0) exitWith {wind};

private _samplePoints = [];
private _unitGridSize = GVAR(totalGridSize) / GVAR(gridResolution);
for "_resX" from -GVAR(gridResolution) to GVAR(gridResolution) do {
	for "_resY" from -GVAR(gridResolution) to GVAR(gridResolution) do {
		_samplePoints pushBack AGLToASL (_vehicle modelToWorld ([_resX, _resY, 0] vectorMultiply _unitGridSize));
	};
};

private _wind = [0, 0, 0];
{
	_wind = _wind vectorAdd ([_x, _dynamicWindMode] call FUNC(getWindPosASL));
} forEach _samplePoints;

_wind = _wind vectorMultiply (1 / (1 max count _samplePoints));

_wind
