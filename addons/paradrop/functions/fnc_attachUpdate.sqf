#include "script_component.hpp"

{
	_x setVariable [QGVAR(attachArray), [time, velocity _x, getPosASL _x, _x worldToModel getPos player]];
} forEach (entities "globemaster_c17");
