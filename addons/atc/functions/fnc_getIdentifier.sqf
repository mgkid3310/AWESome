#include "script_component.hpp"

params [["_input", ""], ["_step", 1]];

if (_input isEqualTo "") exitWith {"A"};

private _inputUni = toArray toUpper _input select 0; // convert to Unicode
private _outputUni = ((_inputUni + _step - 65) mod 26) + 65; // 64: Z(90), 65: A
private _output = toString [_outputUni] select [0, 1];

_output
