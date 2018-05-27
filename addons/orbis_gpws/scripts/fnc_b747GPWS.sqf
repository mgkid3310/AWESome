#include "header_macros.hpp"

DEV_CHAT("orbis_gpws: b747GPWS run");
private _vehicle = _this select 0;

if !((alive _vehicle) && (player in _vehicle)) exitWith {};
DEV_CHAT("orbis_gpws: b747GPWS active");

// initialize variables
_vehicle setVariable ["orbisGPWSmode", "b747"];
_vehicle setVariable ["orbisGPWSready", true];
_vehicle setVariable ["orbisGPWSreadyBeep", true];
private ["_altAGLS", "_altASL", "_altRadar",
	"_posExpect", "_cosAOA", "_flapStatus", "_gearStatus", "_acceleration", "_climeASL", "_climeRadar",
    "_flightphaseOutput", "_distance", "_altDiff", "_altDiffDesired",
	"_damageNow", "_damageWarnLevel"
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
	_cosAOA = (vectorDir _vehicle) vectorCos (velocity _vehicle);
	_flapStatus = _vehicle animationSourcePhase "flap";
	_gearStatus = _vehicle animationSourcePhase "gear";
	_acceleration = (speed _vehicle - _speedOld) / (time - _timeOld); // km/h/s
	_climeASL = (_altASL - _altASLOld) / (time - _timeOld); // m/s
	_climeRadar = (_altRadar - _altRadarOld) / (time - _timeOld); // m/s

	// save data for next loop
	_timeOld = time;
	_speedOld = speed _vehicle;
	_altASLOld = _altASL;
	_altRadarOld = _altRadar;

    // flight phase check
    _flightphaseOutput = [_vehicle, _flightphase, _altRadar, _climeASL] call orbis_gpws_fnc_flightPhaseCheck;
	_flightphase = _flightphaseOutput select 0;
	_distance = _flightphaseOutput select 1;
	_altDiff = _flightphaseOutput select 2;
	_altDiffDesired = _flightphaseOutput select 3;

	_damageNow = damage _vehicle;
	_damageWarnLevel = _vehicle getVariable ["damageWarnLevel", 0];
	switch (_damageWarnLevel) do {
	    case (2): {
	        if (_damageNow < orbis_gpsw_warningDamageLevel) then {
				_damageWarnLevel = 1;
				_vehicle setVariable ["damageWarnLevel", 1];
			};
	        if (_damageNow < orbis_gpsw_cautionDamageLevel) then {
				_damageWarnLevel = 0;
				_vehicle setVariable ["damageWarnLevel", 0];
			};
	    };
		case (1): {
	        if (_damageNow < orbis_gpsw_cautionDamageLevel) then {
				_damageWarnLevel = 0;
				_vehicle setVariable ["damageWarnLevel", 0];
			};
	    };
		default {};
	};

	// GPWS general speach
	if (_vehicle getVariable ["orbisGPWSready", true]) then {
		switch (true) do {
			// b747_counter
			case (_counterGo): {
				DEV_CHAT("orbis_gpws: b747_counter");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_counter"] spawn orbis_gpws_fnc_speakGPWS;
				_ctrWarnOld = _ctrWarnMSLs;
			};

			// b747_jammer
			/* case (_jammerGo): {
				DEV_CHAT("orbis_gpws: b747_jammer");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_jammer"] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["radarLocks", _targeting];
			}; */

			// b747_IFF
			/* case (_IFFgo): {
				DEV_CHAT("orbis_gpws: b747_IFF");
				[_vehicle, "b747_IFF"] spawn orbis_gpws_fnc_speakGPWS;
				_IFFgo = false;
			}; */

			// b747_pullUp (in-flight)
			case (((0 max getTerrainHeightASL _posExpect) > (_posExpect select 2)) && (_flightphase isEqualTo "inFlight")): {
				DEV_CHAT("orbis_gpws: b747_pullUp");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_pullUp"] spawn orbis_gpws_fnc_speakGPWS;
			};

			// b747_altitude (in-flight)
			case ((_altRadar < orbis_gpws_lowAltitude) && (_flightphase isEqualTo "inFlight")): {
				DEV_CHAT("orbis_gpws: b747_altitude");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_altitude"] spawn orbis_gpws_fnc_speakGPWS;
			};

			// b747_warning
			case ((_damageNow > orbis_gpsw_warningDamageLevel) && (_damageWarnLevel < 2)): {
				DEV_CHAT("orbis_gpws: b747_warning");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_warning"] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["damageWarnLevel", 2];
			};

			// b747_caution
			case ((_damageNow > orbis_gpsw_cautionDamageLevel) && (_damageWarnLevel < 1)): {
				DEV_CHAT("orbis_gpws: b747_caution");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_caution"] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["damageWarnLevel", 1];
			};

			// b747_bingo
			case ((fuel _vehicle < orbis_gpws_bingoFuel) && !(_vehicle getVariable ["bingoAlerted", false])): {
				DEV_CHAT("orbis_gpws: b747_bingo");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "b747_bingo"] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["bingoAlerted", true];
			};

			default {};
		};
	};

	// GPWS beep
	if (_vehicle getVariable ["orbisGPWSreadyBeep", true]) then {
		switch (true) do {
			// b747_SAM
			/* case (_samGo): {
				DEV_CHAT("orbis_gpws: b747_SAM");
				_vehicle setVariable ["orbisGPWSreadyBeep", false];
				[_vehicle, "b747_SAM", nil, "orbisGPWSreadyBeep"] spawn orbis_gpws_fnc_speakGPWS;
				_samGo = false;
			}; */

			// b747_lowSpeed
			case ((speed _vehicle < _speedStall) && !(isTouchingGround _vehicle)): {
				DEV_CHAT("orbis_gpws: b747_lowSpeed");
				_vehicle setVariable ["orbisGPWSreadyBeep", false];
				[_vehicle, "b747_lowSpeed", nil, "orbisGPWSreadyBeep"] spawn orbis_gpws_fnc_speakGPWS;
			};

			// b747_highAOA
			case ((_cosAOA < cos orbis_gpws_maxAOA) && (speed _vehicle > 50)): {
				DEV_CHAT("orbis_gpws: b747_highAOA");
				_vehicle setVariable ["orbisGPWSreadyBeep", false];
				[_vehicle, "b747_highAOA", nil, "orbisGPWSreadyBeep"] spawn orbis_gpws_fnc_speakGPWS;
			};

			default {};
		};
	};

	_frameNo = diag_frameNo;
	waitUntil {(diag_frameNo > _frameNo) && (time > _timeOld)};
};
DEV_CHAT("orbis_gpws: b747GPWS loop terminated");

_vehicle setVariable ["orbisGPWSmode", ""];
DEV_CHAT("orbis_gpws: b747GPWS ended");
