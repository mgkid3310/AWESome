private _array = param [0, []];
private _scaleNow = ctrlMapScale ((findDisplay 12) displayCtrl 51);

{
	_x params ["_marker0", "_marker1", "_marker2", "_marker3", "_pos"];

	private _xOffset = orbis_atc_xOffset * (_scaleNow / orbis_atc_scaleStd);
	private _yOffset = orbis_atc_yOffset * (_scaleNow / orbis_atc_scaleStd);

	private _size = getMarkerSize _marker1;
	private _xSpace = (_size select 0) * (_scaleNow / orbis_atc_scaleStd);
	private _ySpace = ((_size select 1) + linearConversion [orbis_atc_fontMin, orbis_atc_fontMax, _scaleNow, orbis_atc_spaceMax, orbis_atc_spaceMin, true]) * (_scaleNow / orbis_atc_scaleStd);

	_marker1 setMarkerPosLocal (_pos vectorAdd [_xOffset + _xSpace, _yOffset, 0]);
	_marker2 setMarkerPosLocal (_pos vectorAdd [_xOffset + _xSpace, _yOffset - _ySpace, 0]);
	_marker3 setMarkerPosLocal (_pos vectorAdd [_xOffset + _xSpace, _yOffset - (_ySpace * 2), 0]);
} forEach _array;
