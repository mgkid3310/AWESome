#include "script_component.hpp"

private _vehicle = vehicle player;
private _timeOld = missionNamespace getVariable [QGVAR(timeOld), -1];
private _frameOld = missionNamespace getVariable [QGVAR(frameOld), -1];

if (!([player, _vehicle, 1] call EFUNC(main,isCrew)) || !(alive _vehicle) || (_timeOld < 0) || (_frameOld < 0)) exitWith {
	missionNamespace setVariable [QGVAR(timeOld), time];
	missionNamespace setVariable [QGVAR(frameOld), diag_frameNo];
};

// check flight phase
private _altAGLS = getPos _vehicle select 2;
private _altASL = getPosASL _vehicle select 2;
private _altRadar = _altAGLS min _altASL;
private _climeASL = velocity _vehicle select 2; // m/s
private _flapStatus = _vehicle animationSourcePhase "flap";
private _gearStatus = _vehicle animationSourcePhase "gear";
private _flightphase = (_vehicle getVariable [QGVAR(flightPhaseParam), ["taxing", 0, 0, 0]]) select 0;
private _flightphaseOutput = [_vehicle, _flightphase, _altRadar, _climeASL, _flapStatus, _gearStatus] call FUNC(flightPhaseCheck);
_vehicle setVariable [QGVAR(flightPhaseParam), _flightphaseOutput];

// automated transponder
if (GVAR(automaticTransponder)) then {
	switch (_vehicle getVariable [QGVAR(transponderMode), 0]) do {
		case (2): {
			if !(isEngineOn _vehicle) exitWith {
				_vehicle setVariable [QGVAR(transponderMode), 0, true];
			};
			if (isTouchingGround _vehicle) exitWith {
				_vehicle setVariable [QGVAR(transponderMode), 1, true];
			};
		};
		case (1): {
			if !(isEngineOn _vehicle) exitWith {
				_vehicle setVariable [QGVAR(transponderMode), 0, true];
			};
			if !(isTouchingGround _vehicle) exitWith {
				_vehicle setVariable [QGVAR(transponderMode), 2, true];
			};
		};
		case (0): {
			if ((isEngineOn _vehicle) && !(isTouchingGround _vehicle)) exitWith {
				_vehicle setVariable [QGVAR(transponderMode), 2, true];
			};
			if (isEngineOn _vehicle) exitWith {
				_vehicle setVariable [QGVAR(transponderMode), 1, true];
			};
		};
	};
};

// run GPWS
private _modePublic = _vehicle getVariable [QGVAR(GPWSmode), "off"];
private _modeLocal = _vehicle getVariable [QGVAR(GPWSmodeLocal), "off"];

if (_target getVariable [QGVAR(isGPWSenabled), false]) then {
	_modePublic = "off";
};

if (_modePublic != _modeLocal) then {
	[_vehicle, _modeLocal] call FUNC(terminateGPWS);
	[_vehicle, _modePublic] call FUNC(startGPWS);
};

switch (_vehicle getVariable [QGVAR(GPWSmodeLocal), "off"]) do {
	case ("b747"): {
		[_vehicle] call FUNC(b747GPWS);
	};
	case ("f16"): {
		[_vehicle] call FUNC(f16GPWS);
	};
	case ("rita"): {
		[_vehicle] call FUNC(ritaGPWS);
	};
	default {};
};

missionNamespace setVariable [QGVAR(timeOld), time];
missionNamespace setVariable [QGVAR(frameOld), diag_frameNo];
