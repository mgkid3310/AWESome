#include "header_macros.hpp"

DEV_CHAT("orbis_gpws: ritaGPWS run");
private _vehicle = _this select 0;

if !((alive _vehicle) && (player in _vehicle)) exitWith {};
DEV_CHAT("orbis_gpws: ritaGPWS active");

// initialize variables
_vehicle setVariable ["orbisGPWSready", true];
_vehicle setVariable ["orbisGPWSreadyBeep", true];
private ["_altAGLS", "_altASL", "_altRadar",
	"_posExpect", "_expectTerrainAlt", "_cosAOA", "_flapStatus", "_gearStatus", "_climeASL", "_flightphaseOutput",
	"_incomingMSLlist", "_incomingMSLs", "_ctrWarnMSLs", "_targetMSLs", "_counterGo", "_damageNow", "_damageWarnLevel",
	"_pitchAndBank", "_pitchAngle", "_bankAngle"
];
private _flightphase = "taxing";
private _timeOld = time;
private _speedOld = speed _vehicle;
private _altASLOld = getPosASL _vehicle select 2;
private _altRadarOld = (getPos _vehicle select 2) min (getPosASL _vehicle select 2);
private _ctrWarnOld = [];
private _speedStall = getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "stallSpeed");
private _maxSpeed = getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "maxSpeed");
DEV_CHAT("orbis_gpws: ritaGPWS variables init done");

private _frameNo = diag_frameNo;
waitUntil {(diag_frameNo > _frameNo) && (time > _timeOld)};

// rita_online
DEV_CHAT("orbis_gpws: rita_online");
_vehicle setVariable ["orbisGPWSready", false];
[_vehicle, "rita_online"] spawn orbis_gpws_fnc_speakGPWS;

while {(alive _vehicle) && (player in _vehicle) && (_vehicle getVariable ["orbisGPWSmodeLocal", "off"] isEqualTo "rita")} do {
	// flight status check
	_altAGLS = getPos _vehicle select 2;
	_altASL = getPosASL _vehicle select 2;
	_altRadar = _altAGLS min _altASL;
	_posExpect = (getPosASL _vehicle) vectorAdd (velocity _vehicle vectorMultiply orbis_gpws_ritaPullupTime);
	_expectTerrainAlt = 0 max getTerrainHeightASL _posExpect;
	_cosAOA = (vectorDir _vehicle) vectorCos (velocity _vehicle);
	_flapStatus = _vehicle animationSourcePhase "flap";
	_gearStatus = _vehicle animationSourcePhase "gear";
	_climeASL = (_altASL - _altASLOld) / (time - _timeOld); // m/s
	_currentSpeed = speed _vehicle;

	_pitchAndBank = _vehicle call BIS_fnc_getPitchBank;
	_pitchAngle = _pitchAndBank select 0;
	_bankAngle = _pitchAndBank select 1;

	// save data for next loop
	_timeOld = time;
	_altASLOld = _altASL;

	// flight phase check
	_flightphaseOutput = [_vehicle, _flightphase, _altRadar, _climeASL, _flapStatus, _gearStatus] call orbis_gpws_fnc_flightPhaseCheck;
	_flightphase = _flightphaseOutput select 0;

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

	// GPWS general speach
	if (_vehicle getVariable ["orbisGPWSready", true]) then {
		switch (true) do {
			// rita_pullUp (inFlight)
			case ((_expectTerrainAlt > (_posExpect select 2)) && (_flightphase isEqualTo "inFlight")): {
				DEV_CHAT("orbis_gpws: rita_pullUp");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "rita_pullUp"] spawn orbis_gpws_fnc_speakGPWS;
			};

			// rita_altitude (inFlight)
			case ((_altRadar < orbis_gpws_ritaLowAltitude) && (_flightphase isEqualTo "inFlight")): {
				DEV_CHAT("orbis_gpws: rita_altitude");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "rita_altitude"] spawn orbis_gpws_fnc_speakGPWS;
			};

			// rita_overload
			case ((_cosAOA < cos orbis_gpws_ritaMaxAOA) && (speed _vehicle > 50)): {
				DEV_CHAT("orbis_gpws: rita_overload");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "rita_overload"] spawn orbis_gpws_fnc_speakGPWS;
			};

			// rita_angle (takeOff / inFlight / landing / final)
			case ((_pitchAngle < orbis_gpws_ritaMaxDive) && (_flightphase in ["takeOff", "inFlight", "landing", "final"])): {
				DEV_CHAT("orbis_gpws: rita_angle");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "rita_angle"] spawn orbis_gpws_fnc_speakGPWS;
			};

			// rita_speed
			case (_currentSpeed > _maxSpeed): {
				DEV_CHAT("orbis_gpws: rita_speed");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "rita_speed"] spawn orbis_gpws_fnc_speakGPWS;
			};

			default {};
		};
	};

	_frameNo = diag_frameNo;
	waitUntil {(diag_frameNo > _frameNo) && (time > _timeOld)};
};
DEV_CHAT("orbis_gpws: ritaGPWS loop terminated");

_vehicle removeEventHandler ["Fired", _chaffFlare];
_vehicle removeEventHandler ["IncomingMissile", _incomingMSL];
DEV_CHAT("orbis_gpws: ritaGPWS ended");
