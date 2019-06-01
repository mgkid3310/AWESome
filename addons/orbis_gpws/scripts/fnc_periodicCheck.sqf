private ["_vehicle", "_mode", "_caller"];

while {true} do {
	_vehicle = vehicle player;
	if (_vehicle isKindOf "Plane") then {
		_modePublic = "off";
		if (isEngineOn _vehicle) then {
			_modePublic = _vehicle getVariable ["orbis_gpws_GPWSmode", "off"];
		};
		_modeLocal = _vehicle getVariable ["orbis_gpws_GPWSmodeLocal", "off"];

		if (_modePublic != _modeLocal) then {
			_vehicle setVariable ["orbis_gpws_GPWSmodeLocal", _modePublic];
			[_vehicle, _modePublic] spawn orbis_gpws_fnc_startGPWS;
		};
	};

	private _frameNo = diag_frameNo;
	waitUntil {diag_frameNo > _frameNo};
};
