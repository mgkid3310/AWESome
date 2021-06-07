params ["_coord", ["_seed", 0]];

private _lowEnd = floor _coord;
private _highEnd = _lowEnd + 1;
private _offsetLow = _coord - _lowEnd;
private _offsetHigh = _coord - _highEnd;

private _gradLow = ((_lowEnd + _seed) random 2) - 1;
private _gradHIgh = ((_highEnd + _seed) random 2) - 1;
private _dotLow = _gradLow * _offsetLow;
private _dotHigh = _gradHIgh * _offsetHigh;

private _smoothStep = (_offsetLow ^ 2) * (3 - 2 * _offsetLow);
private _result = linearConversion [0, 1, _smoothStep, _dotLow, _dotHigh, true];

_result
