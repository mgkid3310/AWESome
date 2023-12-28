#include "script_component.hpp"

params ["_vehicle", "_ATISdata", ["_mode", 0]];

switch (GVAR(displayTextATIS)) do {
	case 1: {
		hintSilent ([_vehicle, _ATISdata, _mode, True] call FUNC(speakATIS));
	};
	case 2: {
		systemChat ([_vehicle, _ATISdata, _mode, True] call FUNC(speakATIS));
	};
};

[_vehicle, _ATISdata, _mode] call FUNC(speakATIS);
