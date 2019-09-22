#include "script_component.hpp"
#include "header_macros.hpp"

private _vehicle = _this select 0;

private _loadData = _vehicle getVariable [QGVAR(f16Data), [time, []/* , objNull */]];
_loadData params ["_timeOld", "_ctrWarnOld", "_altitudeWarnTime"/* , "_target", "_targetOld" */];

if !(_timeOld < time) exitWith {
	_vehicle setVariable [QGVAR(f16Data), _loadData];
};

// flight status check
private _altAGLS = getPos _vehicle select 2;
private _altASL = getPosASL _vehicle select 2;
private _altRadar = _altAGLS min _altASL;
private _posExpect = (getPosASL _vehicle) vectorAdd (velocity _vehicle vectorMultiply GVAR(f16PullupTime));
private _expectTerrainAlt = 0 max getTerrainHeightASL _posExpect;
private _cosAOA = (vectorDir _vehicle) vectorCos (velocity _vehicle);
private _speedStall = getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "stallSpeed");

// flight phase check
private _flightphaseOutput = _vehicle getVariable [QGVAR(flightPhaseParam), ["taxing", 0, 0, 0]];
private _flightphase = _flightphaseOutput select 0;

// incoming mssile check (RWR)
private _incomingMSLlist = _vehicle getVariable [QGVAR(incomingMSLlist), []];
private _incomingMSLs = _incomingMSLlist apply {_x select 0};
private _ctrWarnMSLs =_incomingMSLs select {[_vehicle, _x] call FUNC(isMSLCritical)};
private _targetMSLs = _ctrWarnMSLs - _ctrWarnOld;
private _counterGo = {alive _x} count _targetMSLs > 0;
/* private _samGo = false;
{
	if (getPos (_x select 2) select 2 < 10) exitWith {
		_samGo = true;
	};
} forEach _incomingMSLlist; */

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

// hostile radar lock check
/* private _allRadars = (_vehicle nearObjects GVAR(rwrDetectRange)) select {isClass (configFile >> "CfgVehicles" >> (typeOf _x) >> "Components" >> "SensorsManagerComponent" >> "Components" >> "ActiveRadarSensorComponent")};
private _targeting = _allRadars select {(assignedTarget _x isEqualTo _vehicle) && !(side player isEqualTo side _x)};
private _radarOld = _vehicle getVariable ["radarLocks", []];
private _jammerGo = count (_targeting - _radarOld) > 0; */

// check IFF tone
/* private _target = assignedTarget _vehicle;
private _IFFgo = false;
if ((side player isEqualTo side _target) && !(_target isEqualTo _targetOld)) then {
	_IFFgo = true;
}; */

// GPWS general speach
if ((_vehicle getVariable [QGVAR(nextGPWStime), -1]) < time) then {
	switch (true) do {
		// f16_counter
		case (_counterGo): {
			DEV_CHAT("orbis_gpws: f16_counter");
			[_vehicle, "f16_counter"] call FUNC(speakGPWS);
			_ctrWarnOld = _ctrWarnMSLs;
		};

		// f16_jammer
		/* case (_jammerGo): {
			DEV_CHAT("orbis_gpws: f16_jammer");
			[_vehicle, "f16_jammer"] call FUNC(speakGPWS);
			_vehicle setVariable ["radarLocks", _targeting];
		}; */

		// f16_IFF
		/* case (_IFFgo): {
			DEV_CHAT("orbis_gpws: f16_IFF");
			[_vehicle, "f16_IFF"] call FUNC(speakGPWS);
			_IFFgo = false;
		}; */

		// f16_pullUp (inFlight)
		case ((_expectTerrainAlt > (_posExpect select 2)) && (_flightphase isEqualTo "inFlight")): {
			DEV_CHAT("orbis_gpws: f16_pullUp");
			[_vehicle, "f16_pullUp"] call FUNC(speakGPWS);
		};

		// f16_altitude (inFlight)
		case ((_altitudeWarnTime + 5 < time) && (_altRadar < GVAR(f16LowAltitude)) && (_flightphase isEqualTo "inFlight")): {
			DEV_CHAT("orbis_gpws: f16_altitude");
			[_vehicle, "f16_altitude"] call FUNC(speakGPWS);
			_altitudeWarnTime = time;
		};

		// f16_warning
		case ((_damageNow > GVAR(warningDamageLevel)) && (_damageWarnLevel < 2)): {
			DEV_CHAT("orbis_gpws: f16_warning");
			[_vehicle, "f16_warning"] call FUNC(speakGPWS);
			_vehicle setVariable [QGVAR(damageWarnLevel), 2];
		};

		// f16_caution
		case ((_damageNow > GVAR(cautionDamageLevel)) && (_damageWarnLevel < 1)): {
			DEV_CHAT("orbis_gpws: f16_caution");
			[_vehicle, "f16_caution"] call FUNC(speakGPWS);
			_vehicle setVariable [QGVAR(damageWarnLevel), 1];
		};

		// f16_bingo
		case ((fuel _vehicle < GVAR(f16BingoFuel)) && !(_vehicle getVariable ["bingoAlerted", false])): {
			DEV_CHAT("orbis_gpws: f16_bingo");
			[_vehicle, "f16_bingo"] call FUNC(speakGPWS);
			_vehicle setVariable ["bingoAlerted", true];
		};

		default {};
	};
};

// GPWS beep
if ((_vehicle getVariable [QGVAR(nextBeepTime), -1]) < time) then {
	switch (true) do {
		// f16_SAM
		/* case (_samGo): {
			DEV_CHAT("orbis_gpws: f16_SAM");
			[_vehicle, "f16_SAM", nil, QGVAR(nextBeepTime)] call FUNC(speakGPWS);
			_samGo = false;
		}; */

		// f16_lowSpeed
		case ((speed _vehicle < _speedStall) && !(isTouchingGround _vehicle)): {
			DEV_CHAT("orbis_gpws: f16_lowSpeed");
			[_vehicle, "f16_lowSpeed", nil, QGVAR(nextBeepTime)] call FUNC(speakGPWS);
		};

		// f16_highAOA
		case ((_cosAOA < cos GVAR(f16MaxAOA)) && (speed _vehicle > 50)): {
			DEV_CHAT("orbis_gpws: f16_highAOA");
			[_vehicle, "f16_highAOA", nil, QGVAR(nextBeepTime)] call FUNC(speakGPWS);
		};

		default {};
	};
};

_vehicle setVariable [QGVAR(f16Data), [time, _ctrWarnOld, _altitudeWarnTime/* , _target, _targetOld */]];
