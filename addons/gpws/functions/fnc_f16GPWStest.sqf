#include "script_component.hpp"

params ["_vehicle"];

_vehicle setVariable [QGVAR(GPWStestReady), false, true];
_vehicle setVariable [QGVAR(GPWStestStop), false, true];

// general
["f16", "altitude", 0.5] call FUNC(playTestSound); // done
["f16", "bingo", 0.5] call FUNC(playTestSound); // done
["f16", "caution", 0.5] call FUNC(playTestSound); // done
["f16", "counter", 0.5] call FUNC(playTestSound); // done
["f16", "data", 0.5] call FUNC(playTestSound);
["f16", "IFF", 0.5] call FUNC(playTestSound);
["f16", "jammer", 0.5] call FUNC(playTestSound);
["f16", "lock", 0.5] call FUNC(playTestSound);
["f16", "pullUp", 0.5] call FUNC(playTestSound); // done
["f16", "warning", 0.5] call FUNC(playTestSound); // done
["f16", "chaffFlare", 0.5] call FUNC(playTestSound); // done
["f16", "chaffFlareLow", 0.5] call FUNC(playTestSound); // done
["f16", "chaffFlareOut", 0.5] call FUNC(playTestSound); // done

// beep
["f16", "highAOA", 0.5] call FUNC(playTestSound); // done
["f16", "lowSpeed", 0.5] call FUNC(playTestSound); // done
["f16", "SAM", 0.5] call FUNC(playTestSound); // done

_vehicle setVariable [QGVAR(GPWStestReady), true, true];
_vehicle setVariable [QGVAR(GPWStestStop), false, true];
