private _vehicle = _this select 0;
_vehicle setVariable ["orbisGPWStestReady", false, true];
_vehicle setVariable ["orbisGPWStestStop", false, true];

// general
["f16_altitude", 0.5] call orbis_gpws_fnc_playTestSound; // done
["f16_bingo", 0.5] call orbis_gpws_fnc_playTestSound; // done
["f16_caution", 0.5] call orbis_gpws_fnc_playTestSound; // done
["f16_counter", 0.5] call orbis_gpws_fnc_playTestSound; // done
["f16_data", 0.5] call orbis_gpws_fnc_playTestSound;
["f16_IFF", 0.5] call orbis_gpws_fnc_playTestSound;
["f16_jammer", 0.5] call orbis_gpws_fnc_playTestSound;
["f16_lock", 0.5] call orbis_gpws_fnc_playTestSound;
["f16_pullUp", 0.5] call orbis_gpws_fnc_playTestSound; // done
["f16_warning", 0.5] call orbis_gpws_fnc_playTestSound; // done
["f16_chaffFlare", 0.5] call orbis_gpws_fnc_playTestSound; // done
["f16_chaffFlareLow", 0.5] call orbis_gpws_fnc_playTestSound; // done
["f16_chaffFlareOut", 0.5] call orbis_gpws_fnc_playTestSound; // done

// beep
["f16_highAOA", 0.5] call orbis_gpws_fnc_playTestSound; // done
["f16_lowSpeed", 0.5] call orbis_gpws_fnc_playTestSound; // done
["f16_SAM", 0.5] call orbis_gpws_fnc_playTestSound; // done

_vehicle setVariable ["orbisGPWStestReady", true, true];
_vehicle setVariable ["orbisGPWStestStop", false, true];
