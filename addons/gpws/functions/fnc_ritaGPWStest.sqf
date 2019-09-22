#include "script_component.hpp"

params ["_vehicle"];

_vehicle setVariable [QGVAR(GPWStestReady), false, true];
_vehicle setVariable [QGVAR(GPWStestStop), false, true];

["rita", "altitude", 0.5] call FUNC(playTestSound); // done
["rita", "angle", 0.5] call FUNC(playTestSound); // done
["rita", "ControlsF", 0.5] call FUNC(playTestSound);
["rita", "ejectpilot", 0.5] call FUNC(playTestSound);
["rita", "fuel500", 0.5] call FUNC(playTestSound);
["rita", "fuel800", 0.5] call FUNC(playTestSound);
["rita", "fuel1500", 0.5] call FUNC(playTestSound);
["rita", "FuelF", 0.5] call FUNC(playTestSound);
["rita", "fuellow", 0.5] call FUNC(playTestSound);
["rita", "LEF", 0.5] call FUNC(playTestSound);
["rita", "online", 0.5] call FUNC(playTestSound); // done
["rita", "overload", 0.5] call FUNC(playTestSound); // done
["rita", "pullUp", 0.5] call FUNC(playTestSound); // done
["rita", "REF", 0.5] call FUNC(playTestSound);
["rita", "speed", 0.5] call FUNC(playTestSound); // done
["rita", "spodam", 0.5] call FUNC(playTestSound);
["rita", "SysF", 0.5] call FUNC(playTestSound);

_vehicle setVariable [QGVAR(GPWStestReady), true, true];
_vehicle setVariable [QGVAR(GPWStestStop), false, true];
