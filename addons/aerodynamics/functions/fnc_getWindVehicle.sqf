#include "script_component.hpp"

params ["_vehicle", ["_dynamicWindMode", GVAR(dynamicWindMode)]];

if !(_dynamicWindMode > 0) exitWith {wind};

if !((_dynamicWindMode > 1) && (GVAR(gridResolution) > 0)) exitWith {[getPosASL _vehicle, _dynamicWindMode] call FUNC(getWindPosASL)};

0 boundingBoxReal vehicle player params ["_posMin", "_posMax", "_bbRadius"];
private _gridSizeX = (_posMax select 0) - (_posMin select 0);
private _gridSizeY = (_posMax select 1) - (_posMin select 1);

private _samplePoints = [];
private _resolution = 0 max GVAR(gridResolution);
private _gridSizeX = 0 max _gridSizeX / 2;
private _gridSizeY = 0 max _gridSizeY / 2;
for "_resX" from -_resolution to _resolution do {
	for "_resY" from -_resolution to _resolution do {
		_samplePoints pushBack AGLToASL (_vehicle modelToWorld [_resX * _gridSizeX / _resolution, _resY * _gridSizeY / _resolution, 0]);
	};
};

private _windAverage = [0, 0, 0];
{
	_windAverage = _windAverage vectorAdd ([_x, _dynamicWindMode] call FUNC(getWindPosASL));
} forEach _samplePoints;

_windAverage = _windAverage vectorMultiply (1 / count _samplePoints);

// sampling grid test
if (GVAR(showSamplingGrid)) then {
	private ["_start", "_end", "_vector"];
	{
		_start = ASLToAGL _x;
		_vector = [_start, _dynamicWindMode] call FUNC(getWindPosASL);
		drawLine3D [_start, _start vectorAdd _vector, [1, 0, 0, 1]];
		/* {
			_end = ASLToAGL _x;
			drawLine3D [_start, _end, [1, 1, 1, 1]];
		} forEach _samplePoints; */
	} forEach _samplePoints;
	diag_log str [diag_frameNo, count _samplePoints, _samplePoints];
	systemChat str [wind, _windAverage];
};

_windAverage
