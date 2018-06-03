private _vehicle = _this select 0;
_vehicle setVariable ["orbisGPWStestReady", false, true];
_vehicle setVariable ["orbisGPWStestStop", false, true];

["b747_1000", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747_500", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747_400", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747_300", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747_200", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747_100", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747_50", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747_40", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747_30", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747_20", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747_10", 0.5] call orbis_gpws_fnc_playTestSound; // done

["b747_APPRMIN", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747_MIN", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747_GLIDESLOPE", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747_WINDSHR", 0.5] call orbis_gpws_fnc_playTestSound;
["b747_BNKANGL", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747_DONTSNK", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747_SNKRATE", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747_FLAPS", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747_GEAR", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747_TERRAIN", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747_TOOLOWT", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747_PULLUP", 0.5] call orbis_gpws_fnc_playTestSound; // done
["b747_CHIME", 0.5] call orbis_gpws_fnc_playTestSound;
["b747_ATTEND", 0.5] call orbis_gpws_fnc_playTestSound;
["b747_ALTALRT", 0.5] call orbis_gpws_fnc_playTestSound;
["b747_ALTENTR", 0.5] call orbis_gpws_fnc_playTestSound;
["b747_APDISCO", 0.5] call orbis_gpws_fnc_playTestSound;
["b747_TOWARN", 0.5] call orbis_gpws_fnc_playTestSound;
// ["b747_TRIM", 0.5] call orbis_gpws_fnc_playTestSound;

_vehicle setVariable ["orbisGPWStestReady", true, true];
_vehicle setVariable ["orbisGPWStestStop", false, true];
