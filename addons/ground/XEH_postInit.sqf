#include "script_component.hpp"

// init global variables
GVAR(perFrame) = 1;
GVAR(maxSpeedForward) = 5; // km/h
GVAR(maxSpeedReverse) = 20; // km/h

GVAR(velBase) = 0.9;
GVAR(Pconst) = 0.4;
GVAR(Iconst) = 0.4;
GVAR(Dconst) = 0.2;

GVAR(minIntegralItem) = 25;
GVAR(maxIntegralItem) = 30;

GVAR(towingEventID) = -1;

// add EventHandlers
[QGVAR(detachTowingVehicle), {_this call FUNC(detachTowingVehicle)}] call CBA_fnc_addEventHandler;

// add actions (vanilla)
if (hasInterface && !EGVAR(main,hasACEInteractMenu)) then {
	["CAManBase", "GetInMan", {
		if ((_this select 0) isEqualTo player) then {_this call FUNC(getInAddAction)};
	}] call CBA_fnc_addClassEventHandler;

	[{!isNull player}, {
		if !(vehicle player isEqualTo player) then {
			[player, "", vehicle player, []] call FUNC(getInAddAction);
		};
	}] call CBA_fnc_waitUntilAndExecute;
};
