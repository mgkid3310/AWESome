private _array = param [0, []];
private _scaleNow = ctrlMapScale ((findDisplay 12) displayCtrl 51);

{
    _x params ["_marker0", "_marker1", "_marker2", "_marker3", "_pos"];

    private _xOffset = awesome_atc_xOffset * (_scaleNow / awesome_atc_scaleStd);
    private _yOffset = awesome_atc_yOffset * (_scaleNow / awesome_atc_scaleStd);

    private _size = getMarkerSize _marker1;
    private _xSpace = (_size select 0) * (_scaleNow / awesome_atc_scaleStd);
    private _ySpace = ((_size select 1) + linearConversion [awesome_atc_fontMin, awesome_atc_fontMax, _scaleNow, awesome_atc_spaceMax, awesome_atc_spaceMin, true]) * (_scaleNow / awesome_atc_scaleStd);

    _marker1 setMarkerPosLocal (_pos vectorAdd [_xOffset + _xSpace, _yOffset, 0]);
    _marker2 setMarkerPosLocal (_pos vectorAdd [_xOffset + _xSpace, _yOffset - _ySpace, 0]);
    _marker3 setMarkerPosLocal (_pos vectorAdd [_xOffset + _xSpace, _yOffset - (_ySpace * 2), 0]);
} forEach _array;
