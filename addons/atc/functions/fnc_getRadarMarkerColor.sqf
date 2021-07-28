#include "script_component.hpp"

params ["_side", ["_radarSide", civilian], ["_targetType", 0]];

private _markerColor = "ColorCIV";

switch (_targetType) do {
	case (-1): {
		switch (_side) do {
			case (west): {_markerColor = "ColorWEST"};
			case (east): {_markerColor = "ColorEAST"};
			case (independent): {_markerColor = "ColorGUER"};
			default {};
		};
	};
	case (1): {_markerColor = "ColorYellow"}; // Bogie
	case (2): {_markerColor = "ColorEAST"}; // Bandit
	default {
		switch (true) do {
			case (_side isEqualTo _radarSide): {_markerColor = "ColorWEST";};
			case (_side isEqualTo civilian): {_markerColor = "ColorWEST"};
			default {_markerColor = "ColorYellow"};
		};
	};
};

_markerColor
