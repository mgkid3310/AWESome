#include "script_component.hpp"

params [["_input", 65], ["_step", 0]];

if (_input isEqualType "") then {
	_input = toArray toUpper _input select 0;
};

private _output = ((_input + _step - 65) mod 26) + 65;
_output = toString [_output] select [0, 1];

_output
