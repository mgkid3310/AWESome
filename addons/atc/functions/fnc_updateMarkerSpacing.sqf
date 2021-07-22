#include "script_component.hpp"

params [["_array", []]];

private _scaleNow = ctrlMapScale ((findDisplay 12) displayCtrl 51);

{
	_x params ["_markers", "_pos"];
	_markers params ["_marker0", "_marker1", "_marker2", "_marker3", "_marker4"];

	private _xOffset = GVAR(xOffset) * (_scaleNow / GVAR(scaleStd));
	private _yOffset = GVAR(yOffset) * (_scaleNow / GVAR(scaleStd));
	private _ySpace = (linearConversion [GVAR(fontMin), GVAR(fontMax), _scaleNow, GVAR(spaceMax), GVAR(spaceMin), true]) * (_scaleNow / GVAR(scaleStd));

	_marker1 setMarkerPosLocal (_pos vectorAdd [_xOffset, _yOffset, 0]);
	_marker2 setMarkerPosLocal (_pos vectorAdd [_xOffset, _yOffset - _ySpace, 0]);
	_marker3 setMarkerPosLocal (_pos vectorAdd [_xOffset, _yOffset - (_ySpace * 2), 0]);
	_marker4 setMarkerPosLocal (_pos vectorAdd [_xOffset, _yOffset + _ySpace, 0]);
} forEach _array;
