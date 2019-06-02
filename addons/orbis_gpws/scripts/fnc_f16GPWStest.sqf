private _vehicle = _this select 0;

_vehicle setVariable ["orbis_gpws_GPWStestReady", false, true];
_vehicle setVariable ["orbis_gpws_GPWStestStop", false, true];

// general
["f16", "altitude", 0.5] call orbis_gpws_fnc_playTestSound; // done
["f16", "bingo", 0.5] call orbis_gpws_fnc_playTestSound; // done
["f16", "caution", 0.5] call orbis_gpws_fnc_playTestSound; // done
["f16", "counter", 0.5] call orbis_gpws_fnc_playTestSound; // done
["f16", "data", 0.5] call orbis_gpws_fnc_playTestSound;
["f16", "IFF", 0.5] call orbis_gpws_fnc_playTestSound;
["f16", "jammer", 0.5] call orbis_gpws_fnc_playTestSound;
["f16", "lock", 0.5] call orbis_gpws_fnc_playTestSound;
["f16", "pullUp", 0.5] call orbis_gpws_fnc_playTestSound; // done
["f16", "warning", 0.5] call orbis_gpws_fnc_playTestSound; // done
["f16", "chaffFlare", 0.5] call orbis_gpws_fnc_playTestSound; // done
["f16", "chaffFlareLow", 0.5] call orbis_gpws_fnc_playTestSound; // done
["f16", "chaffFlareOut", 0.5] call orbis_gpws_fnc_playTestSound; // done

// beep
["f16", "highAOA", 0.5] call orbis_gpws_fnc_playTestSound; // done
["f16", "lowSpeed", 0.5] call orbis_gpws_fnc_playTestSound; // done
["f16", "SAM", 0.5] call orbis_gpws_fnc_playTestSound; // done

_vehicle setVariable ["orbis_gpws_GPWStestReady", true, true];
_vehicle setVariable ["orbis_gpws_GPWStestStop", false, true];
