#include "header_macros.hpp"

private _vehicle = _this select 0;

private _loadData = _vehicle getVariable ["orbis_gpws_ritaData", [time]];
_loadData params ["_timeOld"];

if !(_timeOld < time) exitWith {
	_vehicle setVariable ["orbis_gpws_ritaData", _loadData];
};

// flight status check
private _altAGLS = getPos _vehicle select 2;
private _altASL = getPosASL _vehicle select 2;
private _altRadar = _altAGLS min _altASL;
private _posExpect = (getPosASL _vehicle) vectorAdd (velocity _vehicle vectorMultiply orbis_gpws_ritaPullupTime);
private _expectTerrainAlt = 0 max getTerrainHeightASL _posExpect;
private _cosAOA = (vectorDir _vehicle) vectorCos (velocity _vehicle);
private _currentSpeed = speed _vehicle;

private _pitchAndBank = _vehicle call BIS_fnc_getPitchBank;
private _pitchAngle = _pitchAndBank select 0;
private _bankAngle = _pitchAndBank select 1;

// flight phase check
private _flightphaseOutput = _vehicle getVariable ["orbis_gpws_flightPhaseParam", ["taxing", 0, 0, 0]];
private _flightphase = _flightphaseOutput select 0;

private _damageNow = damage _vehicle;
private _damageWarnLevel = _vehicle getVariable ["orbis_gpws_damageWarnLevel", 0];
switch (_damageWarnLevel) do {
	case (2): {
		if (_damageNow < orbis_gpws_warningDamageLevel) then {
			_damageWarnLevel = 1;
			_vehicle setVariable ["orbis_gpws_damageWarnLevel", 1];
		};
		if (_damageNow < orbis_gpws_cautionDamageLevel) then {
			_damageWarnLevel = 0;
			_vehicle setVariable ["orbis_gpws_damageWarnLevel", 0];
		};
	};
	case (1): {
		if (_damageNow < orbis_gpws_cautionDamageLevel) then {
			_damageWarnLevel = 0;
			_vehicle setVariable ["orbis_gpws_damageWarnLevel", 0];
		};
	};
	default {};
};

// GPWS general speach
if (_vehicle getVariable ["orbis_gpws_GPWSready", true]) then {
	switch (true) do {
		// rita_pullUp (inFlight)
		case ((_expectTerrainAlt > (_posExpect select 2)) && (_flightphase isEqualTo "inFlight")): {
			DEV_CHAT("orbis_gpws: rita_pullUp");
			_vehicle setVariable ["orbis_gpws_GPWSready", false];
			[_vehicle, "rita_pullUp"] spawn orbis_gpws_fnc_speakGPWS;
		};

		// rita_altitude (inFlight)
		case ((_altRadar < orbis_gpws_ritaLowAltitude) && (_flightphase isEqualTo "inFlight")): {
			DEV_CHAT("orbis_gpws: rita_altitude");
			_vehicle setVariable ["orbis_gpws_GPWSready", false];
			[_vehicle, "rita_altitude"] spawn orbis_gpws_fnc_speakGPWS;
		};

		// rita_overload
		case ((_cosAOA < cos orbis_gpws_ritaMaxAOA) && (speed _vehicle > 50)): {
			DEV_CHAT("orbis_gpws: rita_overload");
			_vehicle setVariable ["orbis_gpws_GPWSready", false];
			[_vehicle, "rita_overload"] spawn orbis_gpws_fnc_speakGPWS;
		};

		// rita_angle (takeOff / inFlight / landing / final)
		case ((_pitchAngle < orbis_gpws_ritaMaxDive) && (_flightphase in ["takeOff", "inFlight", "landing", "final"])): {
			DEV_CHAT("orbis_gpws: rita_angle");
			_vehicle setVariable ["orbis_gpws_GPWSready", false];
			[_vehicle, "rita_angle"] spawn orbis_gpws_fnc_speakGPWS;
		};

		// rita_speed
		case (_currentSpeed > (getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "maxSpeed"))): {
			DEV_CHAT("orbis_gpws: rita_speed");
			_vehicle setVariable ["orbis_gpws_GPWSready", false];
			[_vehicle, "rita_speed"] spawn orbis_gpws_fnc_speakGPWS;
		};

		default {};
	};
};

_vehicle setVariable ["orbis_gpws_ritaData", [time]];
