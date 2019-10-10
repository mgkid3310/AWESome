#include "script_component.hpp"

params ["_side", ["_radarSide", civilian], ["_radarMode", 0]];

private _markerColor = "ColorCIV";

switch (_radarMode) do {
	case (2): {
		switch (_side) do {
			case (west): {
				_markerColor = "ColorWEST";
			};
			case (east): {
				_markerColor = "ColorEAST";
			};
			case (independent): {
				_markerColor = "ColorGUER";
			};
			default {
				_markerColor = "ColorCIV";
			};
		};
	};
	default {
		switch (true) do {
			case (_side isEqualTo _radarSide): {
				_markerColor = "ColorWEST";
			};
			case (_side isEqualTo civilian): {
				_markerColor = "ColorWEST";
			};
			default {
				_markerColor = "ColorYellow";
			};
		};
	};
};

_markerColor
