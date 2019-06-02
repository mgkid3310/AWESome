private _vehicle = _this select 0;

_vehicle setVariable ["orbis_gpws_GPWStestReady", false, true];
_vehicle setVariable ["orbis_gpws_GPWStestStop", false, true];

["rita", "altitude", 0.5] call orbis_gpws_fnc_playTestSound; // done
["rita", "angle", 0.5] call orbis_gpws_fnc_playTestSound; // done
["rita", "ControlsF", 0.5] call orbis_gpws_fnc_playTestSound;
["rita", "ejectpilot", 0.5] call orbis_gpws_fnc_playTestSound;
["rita", "fuel500", 0.5] call orbis_gpws_fnc_playTestSound;
["rita", "fuel800", 0.5] call orbis_gpws_fnc_playTestSound;
["rita", "fuel1500", 0.5] call orbis_gpws_fnc_playTestSound;
["rita", "FuelF", 0.5] call orbis_gpws_fnc_playTestSound;
["rita", "fuellow", 0.5] call orbis_gpws_fnc_playTestSound;
["rita", "LEF", 0.5] call orbis_gpws_fnc_playTestSound;
["rita", "online", 0.5] call orbis_gpws_fnc_playTestSound; // done
["rita", "overload", 0.5] call orbis_gpws_fnc_playTestSound; // done
["rita", "pullUp", 0.5] call orbis_gpws_fnc_playTestSound; // done
["rita", "REF", 0.5] call orbis_gpws_fnc_playTestSound;
["rita", "speed", 0.5] call orbis_gpws_fnc_playTestSound; // done
["rita", "spodam", 0.5] call orbis_gpws_fnc_playTestSound;
["rita", "SysF", 0.5] call orbis_gpws_fnc_playTestSound;

_vehicle setVariable ["orbis_gpws_GPWStestReady", true, true];
_vehicle setVariable ["orbis_gpws_GPWStestStop", false, true];
