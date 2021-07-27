#include "script_component.hpp"

params [["_lines", []]];

private _newLIst = [];
private _scaleNow = ctrlMapScale ((findDisplay 12) displayCtrl 51);
private _xOffset = GVAR(xOffset) * (_scaleNow / GVAR(scaleStd));
private _yOffset = GVAR(yOffset) * (_scaleNow / GVAR(scaleStd));
private _ySpace = (linearConversion [GVAR(fontMin), GVAR(fontMax), _scaleNow, GVAR(spaceMax), GVAR(spaceMin), true]) * (_scaleNow / GVAR(scaleStd));

{
	_x params ["_markers", "_pos", "_vehicles"];
	_markers params ["_line", "_marker1", "_marker2", "_marker3"];

	if (((_x select 0) getVariable [QGVAR(selectedGCI), false]) && ((_x select 0) getVariable [QGVAR(selectedGCI), false])) then {
		_marker1 setMarkerPosLocal (_pos vectorAdd [_xOffset, _yOffset, 0]);
		_marker2 setMarkerPosLocal (_pos vectorAdd [_xOffset, _yOffset - _ySpace, 0]);
		_marker3 setMarkerPosLocal (_pos vectorAdd [_xOffset, _yOffset - (_ySpace * 2), 0]);

		_newLIst pushBack _x;
	} else {
		deleteMarkerLocal _line;
		deleteMarkerLocal _marker1;
		deleteMarkerLocal _marker2;
		deleteMarkerLocal _marker3;
	};
} forEach _lines;

_newLIst
