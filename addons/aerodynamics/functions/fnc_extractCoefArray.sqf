#include "script_component.hpp"

params ["_array", "_maxValue", "_stepSizeRatio", "_input"];

if !(count _array > 0) exitWith {0};

private _return = 0;
private _stepSize = _maxValue * _stepSizeRatio;
if (_input < (_stepSize * (count _array - 1))) then {
	private _index = (0 max floor (_input / _stepSize)) min (count _array - 2);
	private _lowerStep = _stepSize * _index;
	private _upperStep = _stepSize * (_index + 1);
	private _lowerValue = _array select _index;
	private _upperValue = _array select (_index + 1);

	if (_lowerValue isEqualType "") then {_lowerValue = call compile _lowerValue};
	if (_upperValue isEqualType "") then {_upperValue = call compile _upperValue};

	_return = linearConversion [_lowerStep, _upperStep, _input, _lowerValue, _upperValue, true];
} else {
	_return = _array select -1;
};

_return
