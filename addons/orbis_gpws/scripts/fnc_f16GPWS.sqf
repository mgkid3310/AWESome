#include "header_macros.hpp"

DEV_CHAT("orbis_gpws: f16GPWS run");
private _vehicle = _this select 0;

if !((alive _vehicle) && (player in _vehicle)) exitWith {};
DEV_CHAT("orbis_gpws: f16GPWS active");

// initialize variables
_vehicle setVariable ["orbisGPWSmode", "f16"];
_vehicle setVariable ["orbisGPWSready", true];
_vehicle setVariable ["orbisGPWSreadyBeep", true];
_vehicle setVariable ["lowCMcount", getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "orbisGPWS_lowCMcount")];
private ["_altAGLS", "_altASL", "_altRadar",
	"_posExpect", "_expectTerrainAlt", "_cosAOA", "_flapStatus", "_gearStatus", "_acceleration", "_climeASL", "_climeRadar", "_flightphaseOutput",
	"_incomingMSLlist", "_incomingMSLs", "_ctrWarnMSLs", "_targetMSLs", "_counterGo", "_damageNow", "_damageWarnLevel"/* ,
	"_samGo", _jammerGo", "_target", "_IFFgo" */
];
private _flightphase = "taxing";
private _timeOld = time;
private _speedOld = speed _vehicle;
private _altASLOld = getPosASL _vehicle select 2;
private _altRadarOld = (getPos _vehicle select 2) min (getPosASL _vehicle select 2);
private _ctrWarnOld = [];
// private _targetOld = objNull;
private _speedStall = getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "stallSpeed");
DEV_CHAT("orbis_gpws: f16GPWS variables init done");

// add eventhandlers & store ID
private _chaffFlare = _vehicle addEventHandler ["Fired", {_this spawn orbis_gpws_fnc_f16ChaffFlare}]; // f16_chaffFlare, f16_chaffFlareLow, f16_chaffFlareOut
private _incomingMSL = _vehicle addEventHandler ["IncomingMissile", {_this spawn orbis_gpws_fnc_f16incomingMSL}]; // stack list of incoming MSLs
DEV_CHAT("orbis_gpws: f16GPWS eventHandler added");

private _frameNo = diag_frameNo;
waitUntil {(diag_frameNo > _frameNo) && (time > _timeOld)};

while {(alive _vehicle) && (player in _vehicle) && (_vehicle getVariable ["orbisGPWSmode", ""] isEqualTo "f16")} do {
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

	// save data for next loop
	_timeOld = time;
	_speedOld = speed _vehicle;
	_altASLOld = _altASL;
	_altRadarOld = _altRadar;

	// flight phase check
	_flightphaseOutput = [_vehicle, _flightphase, _altRadar, _climeASL, _flapStatus, _gearStatus] call orbis_gpws_fnc_flightPhaseCheck;
	_flightphase = _flightphaseOutput select 0;

	// incoming mssile check (RWR)
	_incomingMSLlist = _vehicle getVariable ["incomingMSLlist", []];
	_incomingMSLs = _incomingMSLlist apply {_x select 0};
	_ctrWarnMSLs =_incomingMSLs select {(_vehicle distance _x) < (orbis_gpws_mslApproachTime * vectorMagnitude (velocity _vehicle vectorDiff velocity _x))};
	_targetMSLs = _ctrWarnMSLs - _ctrWarnOld;
	_counterGo = {alive _x} count _targetMSLs > 0;
	/* {
		if (getPos (_x select 2) select 2 < 10) exitWith {
			_samGo = true;
		};
	} forEach _incomingMSLlist; */

	_damageNow = damage _vehicle;
	_damageWarnLevel = _vehicle getVariable ["damageWarnLevel", 0];
	switch (_damageWarnLevel) do {
	    case (2): {
	        if (_damageNow < orbis_gpws_warningDamageLevel) then {
				_damageWarnLevel = 1;
				_vehicle setVariable ["damageWarnLevel", 1];
			};
	        if (_damageNow < orbis_gpws_cautionDamageLevel) then {
				_damageWarnLevel = 0;
				_vehicle setVariable ["damageWarnLevel", 0];
			};
	    };
		case (1): {
	        if (_damageNow < orbis_gpws_cautionDamageLevel) then {
				_damageWarnLevel = 0;
				_vehicle setVariable ["damageWarnLevel", 0];
			};
	    };
		default {};
	};

	// hostile radar lock check
	/* private _allRadars = (_vehicle nearObjects orbis_gpws_rwrDetectRange) select {isClass (configFile >> "CfgVehicles" >> (typeOf _x) >> "Components" >> "SensorsManagerComponent" >> "Components" >> "ActiveRadarSensorComponent")};
	private _targeting = _allRadars select {(assignedTarget _x isEqualTo _vehicle) && !(side player isEqualTo side _x)};
	private _radarOld = _vehicle getVariable ["radarLocks", []];
	_jammerGo = count (_targeting - _radarOld) > 0; */

	// check IFF tone
	/* _target = assignedTarget _vehicle;
	if ((side player isEqualTo side _target) && !(_target isEqualTo _targetOld)) then {
		_IFFgo = true;
	};
	_targetOld = _target; */

	// GPWS general speach
	if (_vehicle getVariable ["orbisGPWSready", true]) then {
		switch (true) do {
			// f16_counter
			case (_counterGo): {
				DEV_CHAT("orbis_gpws: f16_counter");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "f16_counter"] spawn orbis_gpws_fnc_speakGPWS;
				_ctrWarnOld = _ctrWarnMSLs;
			};

			// f16_jammer
			/* case (_jammerGo): {
				DEV_CHAT("orbis_gpws: f16_jammer");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "f16_jammer"] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["radarLocks", _targeting];
			}; */

			// f16_IFF
			/* case (_IFFgo): {
				DEV_CHAT("orbis_gpws: f16_IFF");
				[_vehicle, "f16_IFF"] spawn orbis_gpws_fnc_speakGPWS;
				_IFFgo = false;
			}; */

			// f16_pullUp (inFlight)
			case ((_expectTerrainAlt > (_posExpect select 2)) && (_flightphase isEqualTo "inFlight")): {
				DEV_CHAT("orbis_gpws: f16_pullUp");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "f16_pullUp"] spawn orbis_gpws_fnc_speakGPWS;
			};

			// f16_altitude (inFlight)
			case ((_altRadar < orbis_gpws_lowAltitude) && (_flightphase isEqualTo "inFlight")): {
				DEV_CHAT("orbis_gpws: f16_altitude");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "f16_altitude"] spawn orbis_gpws_fnc_speakGPWS;
			};

			// f16_warning
			case ((_damageNow > orbis_gpws_warningDamageLevel) && (_damageWarnLevel < 2)): {
				DEV_CHAT("orbis_gpws: f16_warning");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "f16_warning"] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["damageWarnLevel", 2];
			};

			// f16_caution
			case ((_damageNow > orbis_gpws_cautionDamageLevel) && (_damageWarnLevel < 1)): {
				DEV_CHAT("orbis_gpws: f16_caution");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "f16_caution"] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["damageWarnLevel", 1];
			};

			// f16_bingo
			case ((fuel _vehicle < orbis_gpws_bingoFuel) && !(_vehicle getVariable ["bingoAlerted", false])): {
				DEV_CHAT("orbis_gpws: f16_bingo");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "f16_bingo"] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["bingoAlerted", true];
			};

			default {};
		};
	};

	// GPWS beep
	if (_vehicle getVariable ["orbisGPWSreadyBeep", true]) then {
		switch (true) do {
			// f16_SAM
			/* case (_samGo): {
				DEV_CHAT("orbis_gpws: f16_SAM");
				_vehicle setVariable ["orbisGPWSreadyBeep", false];
				[_vehicle, "f16_SAM", nil, nil, "orbisGPWSreadyBeep"] spawn orbis_gpws_fnc_speakGPWS;
				_samGo = false;
			}; */

			// f16_lowSpeed
			case ((speed _vehicle < _speedStall) && !(isTouchingGround _vehicle)): {
				DEV_CHAT("orbis_gpws: f16_lowSpeed");
				_vehicle setVariable ["orbisGPWSreadyBeep", false];
				[_vehicle, "f16_lowSpeed", nil, nil, "orbisGPWSreadyBeep"] spawn orbis_gpws_fnc_speakGPWS;
			};

			// f16_highAOA
			case ((_cosAOA < cos orbis_gpws_maxAOA) && (speed _vehicle > 50)): {
				DEV_CHAT("orbis_gpws: f16_highAOA");
				_vehicle setVariable ["orbisGPWSreadyBeep", false];
				[_vehicle, "f16_highAOA", nil, nil, "orbisGPWSreadyBeep"] spawn orbis_gpws_fnc_speakGPWS;
			};

			default {};
		};
	};

	_frameNo = diag_frameNo;
	waitUntil {(diag_frameNo > _frameNo) && (time > _timeOld)};
};
DEV_CHAT("orbis_gpws: f16GPWS loop terminated");

_vehicle removeEventHandler ["Fired", _chaffFlare];
_vehicle removeEventHandler ["IncomingMissile", _incomingMSL];
if (_vehicle getVariable ["orbisGPWSmode", ""] isEqualTo "f16") then {
	_vehicle setVariable ["orbisGPWSmode", ""];
};
DEV_CHAT("orbis_gpws: f16GPWS ended");

// f16_data 0.42
// f16_lock 0.61
