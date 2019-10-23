#include "script_component.hpp"
#include "header_macros.hpp"

params ["_vehicle"];

private _loadData = _vehicle getVariable [QGVAR(ritaData), [time]];
_loadData params ["_timeOld"];

if !(_timeOld < time) exitWith {
	_vehicle setVariable [QGVAR(ritaData), _loadData];
};

// flight status check
private _altAGLS = getPos _vehicle select 2;
private _altASLW = getPosASLW _vehicle select 2;
private _altRadar = _altAGLS min _altASLW;
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
if ((_vehicle getVariable [QGVAR(nextGPWStime), -1]) < time) then {
	switch (true) do {
		// rita_pullUp (inFlight)
		case ((_expectTerrainAlt > (_posExpect select 2)) && (_flightphase isEqualTo "inFlight")): {
			DEV_CHAT("orbis_gpws: rita_pullUp");
			[_vehicle, "rita_pullUp"] call FUNC(speakGPWS);
		};

		// rita_altitude (inFlight)
		case ((_altRadar < GVAR(ritaLowAltitude)) && (_flightphase isEqualTo "inFlight")): {
			DEV_CHAT("orbis_gpws: rita_altitude");
			[_vehicle, "rita_altitude"] call FUNC(speakGPWS);
		};

		// rita_overload
		case ((_cosAOA < cos GVAR(ritaMaxAOA)) && (speed _vehicle > 50)): {
			DEV_CHAT("orbis_gpws: rita_overload");
			[_vehicle, "rita_overload"] call FUNC(speakGPWS);
		};

		// rita_angle (takeOff / inFlight / landing / final)
		case ((_pitchAngle < GVAR(ritaMaxDive)) && (_flightphase in ["takeOff", "inFlight", "landing", "final"])): {
			DEV_CHAT("orbis_gpws: rita_angle");
			[_vehicle, "rita_angle"] call FUNC(speakGPWS);
		};

		// rita_speed
		case (_currentSpeed > (getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "maxSpeed"))): {
			DEV_CHAT("orbis_gpws: rita_speed");
			[_vehicle, "rita_speed"] call FUNC(speakGPWS);
		};

		default {};
	};
};

_vehicle setVariable [QGVAR(ritaData), [time]];
