#include "header_macros.hpp"

DEV_CHAT("orbis_gpws: b747GPWS run");
private _vehicle = _this select 0;

if !((alive _vehicle) && (player in _vehicle) && (_vehicle getVariable ["orbisGPWSmode", ""] != "b747")) exitWith {};
DEV_CHAT("orbis_gpws: b747GPWS active");

// initialize variables
_vehicle setVariable ["orbisGPWSmode", "b747", true];
_vehicle setVariable ["orbisGPWSready", true];
_vehicle setVariable ["orbisGPWSreadyBeep", true];
private ["_altAGLS", "_altASL", "_altRadar",
	"_posExpect", "_expectTerrainAlt", "_cosAOA", "_flapStatus", "_gearStatus", "_acceleration", "_climeASL", "_climeRadar",
	"_pitchAndBank", "_pitchAngle", "_bankAngle",
    "_flightphaseOutput", "_distance", "_altDiff", "_altDiffDesired", "_tooLow"
];
private _flightphase = "taxing";
private _timeOld = time;
private _speedOld = speed _vehicle;
private _altASLOld = getPosASL _vehicle select 2;
private _altRadarOld = (getPos _vehicle select 2) min (getPosASL _vehicle select 2);
private _ctrWarnOld = [];
// private _targetOld = objNull;
private _speedStall = getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "stallSpeed");
DEV_CHAT("orbis_gpws: b747GPWS variables init done");

private _frameNo = diag_frameNo;
waitUntil {(diag_frameNo > _frameNo) && (time > _timeOld)};

while {(alive _vehicle) && (player in _vehicle) && (_vehicle getVariable ["orbisGPWSmode", ""] isEqualTo "b747")} do {
	// flight status check
	_altAGLS = getPos _vehicle select 2;
	_altASL = getPosASL _vehicle select 2;
	_altRadar = _altAGLS min _altASL;
	_posExpect = (getPosASL _vehicle) vectorAdd (velocity _vehicle vectorMultiply orbis_gpws_pullupTime);
    _expectTerrainAlt = 0 max getTerrainHeightASL _posExpect;
	_cosAOA = (vectorDir _vehicle) vectorCos (velocity _vehicle);
	_flapStatus = _vehicle animationSourcePhase "flap";
	_gearStatus = _vehicle animationSourcePhase "gear";
	_acceleration = (speed _vehicle - _speedOld) / (time - _timeOld); // km/h/s
	_climeASL = (_altASL - _altASLOld) / (time - _timeOld); // m/s
	_climeRadar = (_altRadar - _altRadarOld) / (time - _timeOld); // m/s

    _pitchAndBank = _vehicle call BIS_fnc_getPitchBank;
    _pitchAngle = _pitchAndBank select 0;
    _bankAngle = _pitchAndBank select 1;

	// save data for next loop
	_timeOld = time;
	_speedOld = speed _vehicle;
	_altASLOld = _altASL;
	_altRadarOld = _altRadar;

    // flight phase check
    _flightphaseOutput = [_vehicle, _flightphase, _altRadar, _climeASL, _flapStatus, _gearStatus] call orbis_gpws_fnc_flightPhaseCheck;
	_flightphase = _flightphaseOutput select 0;
	_distance = _flightphaseOutput select 1;
	_altDiff = _flightphaseOutput select 2;
	_altDiffDesired = _flightphaseOutput select 3;

    _tooLow = !(_flightphase in ["taxing", "touchDown"]) && (_altRadar < orbis_gpws_tooLowAlt);

	_minWarnLevel = _vehicle getVariable ["minWarnLevel", 0];
	switch (_minWarnLevel) do {
	    case (2): {
	        if (_altDiff > orbis_gpws_minAlt) then {
				_minWarnLevel = 1;
				_vehicle setVariable ["minWarnLevel", 1];
			};
	        if (_altDiff > orbis_gpws_appMinAlt) then {
				_minWarnLevel = 0;
				_vehicle setVariable ["minWarnLevel", 0];
			};
	    };
		case (1): {
	        if (_altDiff > orbis_gpws_appMinAlt) then {
				_minWarnLevel = 0;
				_vehicle setVariable ["minWarnLevel", 0];
			};
	    };
		default {};
	};

	_altInformLevel = _vehicle getVariable ["altInformLevel", 2000];
	if ((_altInformLevel < 10) && (_altDiff > (10 * orbis_gpws_ftToM))) then {
		_altInformLevel = 10;
		_vehicle setVariable ["altInformLevel", 10];
	};
	if ((_altInformLevel < 20) && (_altDiff > (20 * orbis_gpws_ftToM))) then {
		_altInformLevel = 20;
		_vehicle setVariable ["altInformLevel", 20];
	};
	if ((_altInformLevel < 30) && (_altDiff > (30 * orbis_gpws_ftToM))) then {
		_altInformLevel = 30;
		_vehicle setVariable ["altInformLevel", 30];
	};
	if ((_altInformLevel < 40) && (_altDiff > (40 * orbis_gpws_ftToM))) then {
		_altInformLevel = 40;
		_vehicle setVariable ["altInformLevel", 40];
	};
	if ((_altInformLevel < 50) && (_altDiff > (50 * orbis_gpws_ftToM))) then {
		_altInformLevel = 50;
		_vehicle setVariable ["altInformLevel", 50];
	};
	if ((_altInformLevel < 100) && (_altDiff > (100 * orbis_gpws_ftToM))) then {
		_altInformLevel = 100;
		_vehicle setVariable ["altInformLevel", 100];
	};
	if ((_altInformLevel < 200) && (_altDiff > (200 * orbis_gpws_ftToM))) then {
		_altInformLevel = 200;
		_vehicle setVariable ["altInformLevel", 200];
	};
	if ((_altInformLevel < 300) && (_altDiff > (300 * orbis_gpws_ftToM))) then {
		_altInformLevel = 300;
		_vehicle setVariable ["altInformLevel", 300];
	};
	if ((_altInformLevel < 400) && (_altDiff > (400 * orbis_gpws_ftToM))) then {
		_altInformLevel = 400;
		_vehicle setVariable ["altInformLevel", 400];
	};
	if ((_altInformLevel < 500) && (_altDiff > (500 * orbis_gpws_ftToM))) then {
		_altInformLevel = 500;
		_vehicle setVariable ["altInformLevel", 500];
	};
	if ((_altInformLevel < 1000) && (_altDiff > (1000 * orbis_gpws_ftToM))) then {
		_altInformLevel = 1000;
		_vehicle setVariable ["altInformLevel", 1000];
	};

	// GPWS general speach
	if (_vehicle getVariable ["orbisGPWSready", true]) then {
		switch (true) do {
			// b747_PULLUP (inFlight)
			case ((_flightphase isEqualTo "inFlight") && (_expectTerrainAlt > (_posExpect select 2))): {
				DEV_CHAT("orbis_gpws: b747_PULLUP");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_PULLUP", orbis_gpws_delay] spawn orbis_gpws_fnc_speakGPWS;
			};

			// b747_TOOLOWT (takeOff / inFlight / landing)
			case ((_flightphase in ["takeOff", "inFlight", "landing"]) && (_altRadar > 5) && _tooLow && (_expectTerrainAlt > _altASL)): {
				DEV_CHAT("orbis_gpws: b747_TOOLOWT");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_TOOLOWT", orbis_gpws_delay] spawn orbis_gpws_fnc_speakGPWS;
			};

			// b747_TERRAIN (takeOff / inFlight / landing)
			case ((_flightphase in ["takeOff", "inFlight", "landing"]) && (_altRadar > 5) && (_expectTerrainAlt > _altASL)): {
				DEV_CHAT("orbis_gpws: b747_TERRAIN");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_TERRAIN", orbis_gpws_delay] spawn orbis_gpws_fnc_speakGPWS;
			};

			// b747_DONTSNK (takeOff)
			case ((_flightphase isEqualTo "takeOff") && (_altRadar > 5) && (_altRadar < 100) && (_climeASL < 0)): {
				DEV_CHAT("orbis_gpws: b747_DONTSNK");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_DONTSNK", orbis_gpws_delay] spawn orbis_gpws_fnc_speakGPWS;
			};

			// b747_SNKRATE
			case (_climeASL < orbis_gpws_maxSinkeRate): {
				DEV_CHAT("orbis_gpws: b747_SNKRATE");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_SNKRATE", orbis_gpws_delay] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["minWarnLevel", 1];
			};

			// b747_BNKANGL
			case ((abs _bankAngle) > orbis_gpws_maxBankAngle): {
				DEV_CHAT("orbis_gpws: b747_BNKANGL");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_BNKANGL", orbis_gpws_delay] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["minWarnLevel", 1];
			};

			// b747_GLIDESLOPE (landing, final)
			case ((_flightphase in ["landing", "final"]) && (((_altDiffDesired - 50) min (_altDiffDesired * 0.8)) > _altDiff)): {
				DEV_CHAT("orbis_gpws: b747_GLIDESLOPE");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_GLIDESLOPE", orbis_gpws_delay] spawn orbis_gpws_fnc_speakGPWS;
			};

			// b747_FLAPS (inFlight, landing, final)
			case (_tooLow && (_flightphase in ["inFlight", "landing", "final"]) && (_flapStatus < 0.1)): {
				DEV_CHAT("orbis_gpws: b747_FLAPS");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_FLAPS", orbis_gpws_delay] spawn orbis_gpws_fnc_speakGPWS;
			};

            // b747_GEAR (inFlight, landing, final)
            case (_tooLow && (_flightphase in ["inFlight", "landing", "final"]) && (_gearStatus > 0.9)): {
                DEV_CHAT("orbis_gpws: b747_GEAR");
                _vehicle setVariable ["orbisGPWSready", false];
                [_vehicle, "b747_GEAR", orbis_gpws_delay] spawn orbis_gpws_fnc_speakGPWS;
            };

			// b747_MIN (landing / final)
			case ((_flightphase in ["landing", "final"]) && (_altDiff < orbis_gpws_minAlt) && (_minWarnLevel < 2)): {
				DEV_CHAT("orbis_gpws: b747_MIN");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_MIN", orbis_gpws_delay] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["minWarnLevel", 2];
			};

			// b747_APPRMIN (landing / final)
			case ((_flightphase in ["landing", "final"]) && (_altDiff < orbis_gpws_appMinAlt) && (_minWarnLevel < 1)): {
				DEV_CHAT("orbis_gpws: b747_APPRMIN");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_APPRMIN", orbis_gpws_delay] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["minWarnLevel", 1];
			};

			// b747_10 (landing / final)
			case ((_flightphase in ["landing", "final"]) && (_altDiff < (10 * orbis_gpws_ftToM)) && (_altInformLevel > 10)): {
				DEV_CHAT("orbis_gpws: b747_10");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_10"] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["altInformLevel", 10];
			};

			// b747_20 (landing / final)
			case ((_flightphase in ["landing", "final"]) && (_altDiff < (20 * orbis_gpws_ftToM)) && (_altInformLevel > 20)): {
				DEV_CHAT("orbis_gpws: b747_20");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_20"] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["altInformLevel", 20];
			};

			// b747_30 (landing / final)
			case ((_flightphase in ["landing", "final"]) && (_altDiff < (30 * orbis_gpws_ftToM)) && (_altInformLevel > 30)): {
				DEV_CHAT("orbis_gpws: b747_30");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_30"] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["altInformLevel", 30];
			};

			// b747_40 (landing / final)
			case ((_flightphase in ["landing", "final"]) && (_altDiff < (40 * orbis_gpws_ftToM)) && (_altInformLevel > 40)): {
				DEV_CHAT("orbis_gpws: b747_40");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_40"] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["altInformLevel", 40];
			};

			// b747_50 (landing / final)
			case ((_flightphase in ["landing", "final"]) && (_altDiff < (50 * orbis_gpws_ftToM)) && (_altInformLevel > 50)): {
				DEV_CHAT("orbis_gpws: b747_50");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_50"] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["altInformLevel", 50];
			};

			// b747_100 (landing / final)
			case ((_flightphase in ["landing", "final"]) && (_altDiff < (100 * orbis_gpws_ftToM)) && (_altInformLevel > 100)): {
				DEV_CHAT("orbis_gpws: b747_100");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_100"] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["altInformLevel", 100];
			};

			// b747_200 (landing / final)
			case ((_flightphase in ["landing", "final"]) && (_altDiff < (200 * orbis_gpws_ftToM)) && (_altInformLevel > 200)): {
				DEV_CHAT("orbis_gpws: b747_200");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_200", orbis_gpws_delay] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["altInformLevel", 200];
			};

			// b747_300 (landing / final)
			case ((_flightphase in ["landing", "final"]) && (_altDiff < (300 * orbis_gpws_ftToM)) && (_altInformLevel > 300)): {
				DEV_CHAT("orbis_gpws: b747_300");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_300", orbis_gpws_delay] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["altInformLevel", 300];
			};

			// b747_400 (landing / final)
			case ((_flightphase in ["landing", "final"]) && (_altDiff < (400 * orbis_gpws_ftToM)) && (_altInformLevel > 400)): {
				DEV_CHAT("orbis_gpws: b747_400");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_400", orbis_gpws_delay] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["altInformLevel", 400];
			};

			// b747_500 (landing / final)
			case ((_flightphase in ["landing", "final"]) && (_altDiff < (500 * orbis_gpws_ftToM)) && (_altInformLevel > 500)): {
				DEV_CHAT("orbis_gpws: b747_500");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_500", orbis_gpws_delay] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["altInformLevel", 500];
			};

			// b747_1000 (landing / final)
			case ((_flightphase in ["landing", "final"]) && (_altDiff < (1000 * orbis_gpws_ftToM)) && (_altDiff > (900 * orbis_gpws_ftToM)) && (_altInformLevel > 1000)): {
				DEV_CHAT("orbis_gpws: b747_1000");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_1000", orbis_gpws_delay] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["altInformLevel", 1000];
			};

			default {};
		};
	};

	_frameNo = diag_frameNo;
	waitUntil {(diag_frameNo > _frameNo) && (time > _timeOld)};
};
DEV_CHAT("orbis_gpws: b747GPWS loop terminated");

_vehicle setVariable ["minWarnLevel", 0];
_vehicle setVariable ["altInformLevel", 2000];
DEV_CHAT("orbis_gpws: b747GPWS ended");
