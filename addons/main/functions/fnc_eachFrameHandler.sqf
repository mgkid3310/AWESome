#include "script_component.hpp"

private _crewStatus = [vehicle player, assignedVehicleRole player];
if !(_crewStatus isEqualTo (player getVariable [QGVAR(crewStatus), []])) then {
	player setVariable [QGVAR(crewStatus), _crewStatus, true];
};
