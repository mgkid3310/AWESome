params ["_array", "_maxValue", "_stepSizeRatio", "_input"];

private _return = 0;
private _stepSize = _maxValue * _stepSizeRatio;
if (_input < (_stepSize * (count _array - 1))) then {
    private _index = (0 max floor (_input / _stepSize)) min (count _array - 2);
    private _lowerStep = _stepSize * _index;
    private _upperStep = _stepSize * (_index + 1);
    private _lowerValue = _array select _index;
    private _upperValue = _array select (_index + 1);
    _return = linearConversion [_lowerStep, _upperStep, _input, _lowerValue, _upperValue, true];
} else {
    _return = _array select (count _array - 1);
};

_return
