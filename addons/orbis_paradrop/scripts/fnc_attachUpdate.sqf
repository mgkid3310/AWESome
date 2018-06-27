{
	_x setVariable ["orbis_paradrop_attachArray", [time, velocity _x, getPosASL _x, _x worldToModel getPos player]];
} forEach (entities "globemaster_c17");
