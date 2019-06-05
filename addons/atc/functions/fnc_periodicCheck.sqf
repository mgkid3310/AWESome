#include "script_component.hpp"

private _lastTime = 0;

while {true} do {
	_lastTime = (vehicle player) getVariable ["orbisATISlastTime", CBA_missionTime];
	if (_lastTime > (CBA_missionTime + 60)) then {
		(vehicle player) setVariable ["orbisATISready", true, true];
	};

	sleep 10;
};
