private _vehicle = vehicle player;
private _timeOld = missionNamespace getVariable ["orbis_gpws_timeOld", -1];
private _frameOld = missionNamespace getVariable ["orbis_gpws_frameOld", -1];

if (!([nil, nil, 1] call orbis_awesome_fnc_isCrew) || !(alive _vehicle) || (_timeOld < 0) || (_frameOld < 0)) exitWith {
	missionNamespace setVariable ["orbis_gpws_timeOld", time];
	missionNamespace setVariable ["orbis_gpws_frameOld", diag_frameNo];
};

// check flight phase
private _altAGLS = getPos _vehicle select 2;
private _altASL = getPosASL _vehicle select 2;
private _altRadar = _altAGLS min _altASL;
private _climeASL = velocity _vehicle select 2; // m/s
private _flapStatus = _vehicle animationSourcePhase "flap";
private _gearStatus = _vehicle animationSourcePhase "gear";
private _flightphase = (_vehicle getVariable ["orbis_gpws_flightPhaseParam", ["taxing", 0, 0, 0]]) select 0;
private _flightphaseOutput = [_vehicle, _flightphase, _altRadar, _climeASL, _flapStatus, _gearStatus] call orbis_gpws_fnc_flightPhaseCheck;
_vehicle setVariable ["orbis_gpws_flightPhaseParam", _flightphaseOutput];

// automated transponder
if (orbis_gpws_automaticTransponder) then {
	switch (_vehicle getVariable ["orbis_gpws_transponderMode", 0]) do {
		case (2): {
			if !(isEngineOn _vehicle) exitWith {
				_vehicle setVariable ["orbis_gpws_transponderMode", 0, true];
			};
			if (_altRadar < 5) exitWith {
				_vehicle setVariable ["orbis_gpws_transponderMode", 1, true];
			};
		};
		case (1): {
			if !(isEngineOn _vehicle) exitWith {
				_vehicle setVariable ["orbis_gpws_transponderMode", 0, true];
			};
			if (_altRadar >= 5) exitWith {
				_vehicle setVariable ["orbis_gpws_transponderMode", 2, true];
			};
		};
		case (0): {
			if ((isEngineOn _vehicle) && (_altRadar >= 5)) exitWith {
				_vehicle setVariable ["orbis_gpws_transponderMode", 2, true];
			};
			if (isEngineOn _vehicle) exitWith {
				_vehicle setVariable ["orbis_gpws_transponderMode", 1, true];
			};
		};
	};
};

// run GPWS
private _modePublic = _vehicle getVariable ["orbis_gpws_GPWSmode", "off"];
private _modeLocal = _vehicle getVariable ["orbis_gpws_GPWSmodeLocal", "off"];

if (_target getVariable ["orbis_gpws_GPWSenabled", false]) then {
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
