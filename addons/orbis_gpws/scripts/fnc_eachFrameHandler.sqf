private _vehicle = vehicle player;
private _timeOld = missionNamespace getVariable ["orbis_gpws_timeOld", -1];
private _frameOld = missionNamespace getVariable ["orbis_gpws_frameOld", -1];

if (!([nil, nil, 1] call orbis_awesome_fnc_isCrew) || !(alive _vehicle) || (_timeOld < 0) || (_frameOld < 0)) exitWith {
	missionNamespace setVariable ["orbis_gpws_timeOld", time];
	missionNamespace setVariable ["orbis_gpws_frameOld", diag_frameNo];
};

private _modePublic = _vehicle getVariable ["orbisGPWSmode", "off"];
private _modeLocal = _vehicle getVariable ["orbisGPWSmodeLocal", "off"];

if (_target getVariable ["orbisGPWSenabled", false]) then {
	_modePublic = "off";
};

if (_modePublic != _modeLocal) then {
	[_vehicle, _modeLocal] call orbis_gpws_fnc_terminateGPWS;
	[_vehicle, _modePublic] call orbis_gpws_fnc_startGPWS;
};

switch (_vehicle getVariable ["orbis_gpws_GPWSmodeLocal", "off"]) do {
	case ("b747"): {
		[_vehicle] call orbis_gpws_fnc_b747GPWS;
	};
	case ("f16"): {
		[_vehicle] call orbis_gpws_fnc_f16GPWS;
	};
	case ("rita"): {
		[_vehicle] call orbis_gpws_fnc_ritaGPWS;
	};
	default {};
};

missionNamespace setVariable ["orbis_gpws_timeOld", time];
missionNamespace setVariable ["orbis_gpws_frameOld", diag_frameNo];
