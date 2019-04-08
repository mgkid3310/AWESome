private _vehicle = _this select 0;

_vehicle setVariable ["orbisGPWStestReady", false, true];
_vehicle setVariable ["orbisGPWStestStop", false, true];

["b747", "1000", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747", "500", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747", "400", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747", "300", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747", "200", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747", "100", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747", "50", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747", "40", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747", "30", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747", "20", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747", "10", 0.5] call orbis_gpws_fnc_playTestSound; // done

["b747", "APPRMIN", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747", "MIN", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747", "GLIDESLOPE", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747", "WINDSHR", 0.5] call orbis_gpws_fnc_playTestSound;
["b747", "BNKANGL", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747", "DONTSNK", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747", "SNKRATE", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747", "FLAPS", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747", "GEAR", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747", "TERRAIN", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747", "TOOLOWT", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747", "PULLUP", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747", "CHIME", 0.5] call orbis_gpws_fnc_playTestSound;
["b747", "ATTEND", 0.5] call orbis_gpws_fnc_playTestSound;
["b747", "ALTALRT", 0.5] call orbis_gpws_fnc_playTestSound;
["b747", "ALTENTR", 0.5] call orbis_gpws_fnc_playTestSound;
["b747", "APDISCO", 0.5] call orbis_gpws_fnc_playTestSound;
["b747", "TOWARN", 0.5] call orbis_gpws_fnc_playTestSound;
// ["b747", "TRIM", 0.5] call orbis_gpws_fnc_playTestSound;

_vehicle setVariable ["orbisGPWStestReady", true, true];
_vehicle setVariable ["orbisGPWStestStop", false, true];
