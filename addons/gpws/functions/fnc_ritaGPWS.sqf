#include "script_component.hpp"
#include "header_macros.hpp"

private _vehicle = _this select 0;

private _loadData = _vehicle getVariable [QGVAR(ritaData), [time]];
_loadData params ["_timeOld"];

if !(_timeOld < time) exitWith {
	_vehicle setVariable [QGVAR(ritaData), _loadData];
};

// flight status check
private _altAGLS = getPos _vehicle select 2;
private _altASL = getPosASL _vehicle select 2;
private _altRadar = _altAGLS min _altASL;
private _posExpect = (getPosASL _vehicle) vectorAdd (velocity _vehicle vectorMultiply GVAR(ritaPullupTime));
private _expectTerrainAlt = 0 max getTerrainHeightASL _posExpect;
private _cosAOA = (vectorDir _vehicle) vectorCos (velocity _vehicle);
private _currentSpeed = speed _vehicle;

private _pitchAndBank = _vehicle call BIS_fnc_getPitchBank;
private _pitchAngle = _pitchAndBank select 0;
private _bankAngle = _pitchAndBank select 1;

// flight phase check
private _flightphaseOutput = _vehicle getVariable [QGVAR(flightPhaseParam), ["taxing", 0, 0, 0]];
private _flightphase = _flightphaseOutput select 0;

private _damageNow = damage _vehicle;
private _damageWarnLevel = _vehicle getVariable [QGVAR(damageWarnLevel), 0];
switch (_damageWarnLevel) do {
	case (2): {
		if (_damageNow < GVAR(warningDamageLevel)) then {
			_damageWarnLevel = 1;
			_vehicle setVariable [QGVAR(damageWarnLevel), 1];
		};
		if (_damageNow < GVAR(cautionDamageLevel)) then {
			_damageWarnLevel = 0;
			_vehicle setVariable [QGVAR(damageWarnLevel), 0];
		};
	};
	case (1): {
		if (_damageNow < GVAR(cautionDamageLevel)) then {
			_damageWarnLevel = 0;
			_vehicle setVariable [QGVAR(damageWarnLevel), 0];
		};
	};
	default {};
};

// GPWS general speach
if (_vehicle getVariable [QGVAR(GPWSready), true]) then {
	switch (true) do {
		// rita_pullUp (inFlight)
		case ((_expectTerrainAlt > (_posExpect select 2)) && (_flightphase isEqualTo "inFlight")): {
			DEV_CHAT("orbis_gpws: rita_pullUp");
			_vehicle setVariable [QGVAR(GPWSready), false];
			[_vehicle, "rita_pullUp"] spawn FUNC(speakGPWS);
		};

		// rita_altitude (inFlight)
		case ((_altRadar < GVAR(ritaLowAltitude)) && (_flightphase isEqualTo "inFlight")): {
			DEV_CHAT("orbis_gpws: rita_altitude");
			_vehicle setVariable [QGVAR(GPWSready), false];
			[_vehicle, "rita_altitude"] spawn FUNC(speakGPWS);
		};

		// rita_overload
		case ((_cosAOA < cos GVAR(ritaMaxAOA)) && (speed _vehicle > 50)): {
			DEV_CHAT("orbis_gpws: rita_overload");
			_vehicle setVariable [QGVAR(GPWSready), false];
			[_vehicle, "rita_overload"] spawn FUNC(speakGPWS);
		};

		// rita_angle (takeOff / inFlight / landing / final)
		case ((_pitchAngle < GVAR(ritaMaxDive)) && (_flightphase in ["takeOff", "inFlight", "landing", "final"])): {
			DEV_CHAT("orbis_gpws: rita_angle");
			_vehicle setVariable [QGVAR(GPWSready), false];
			[_vehicle, "rita_angle"] spawn FUNC(speakGPWS);
		};

		// rita_speed
		case (_currentSpeed > (getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "maxSpeed"))): {
			DEV_CHAT("orbis_gpws: rita_speed");
			_vehicle setVariable [QGVAR(GPWSready), false];
			[_vehicle, "rita_speed"] spawn FUNC(speakGPWS);
		};

		default {};
	};
};

_vehicle setVariable [QGVAR(ritaData), [time]];
