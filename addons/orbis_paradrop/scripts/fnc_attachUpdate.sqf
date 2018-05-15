{
	_x setVariable ["orbis_paradrop_attachArray", [time, velocity _x, getPosASL _x, [_x, player] call orbis_paradrop_fnc_getPosRel]];
} forEach (entities "globemaster_c17");
