private _vehicle = _this select 0;

_vehicle setVariable ["orbisGPWStestReady", false, true];
_vehicle setVariable ["orbisGPWStestStop", false, true];

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

_vehicle setVariable ["orbisGPWStestReady", true, true];
_vehicle setVariable ["orbisGPWStestStop", false, true];
