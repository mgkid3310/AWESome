private _array = param [0, []];

private _scaleStd = orbis_atc_scaleStd;
private _fontMin = orbis_atc_fontMin;
private _fontMax = orbis_atc_fontMax;
private _lineSpacing = orbis_atc_lineSpacing;
private _scaleNow = ctrlMapScale ((findDisplay 12) displayCtrl 51);

{
    _x params ["_marker1", "_marker2", "_marker3", "_pos"];

    private _size = getMarkerSize _marker1;
    private _xSpace = (_size select 0) * (_scaleNow / _scaleStd);
    private _ySpace = ((_size select 1) + linearConversion [_fontMin, _fontMax, _scaleNow, _lineSpacing, 0, true]) * (_scaleNow / _scaleStd);

    _marker2 setMarkerPosLocal (_pos vectorAdd [_xSpace, -_ySpace, 0]);
    _marker3 setMarkerPosLocal (_pos vectorAdd [_xSpace, -_ySpace * 2, 0]);
} forEach _array;
