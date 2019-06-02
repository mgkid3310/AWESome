#include "header_macros.hpp"

private _vehicle = _this select 0;

private _loadData = _vehicle getVariable ["orbis_gpws_f16Data", [time, []/* , objNull */]];
_loadData params ["_timeOld", "_ctrWarnOld"/* , "_targetOld" */];

if !(_timeOld < time) exitWith {
	_vehicle setVariable ["orbis_gpws_f16Data", _loadData];
};

// flight status check
private _altAGLS = getPos _vehicle select 2;
private _altASL = getPosASL _vehicle select 2;
private _altRadar = _altAGLS min _altASL;
private _posExpect = (getPosASL _vehicle) vectorAdd (velocity _vehicle vectorMultiply orbis_gpws_f16PullupTime);
private _expectTerrainAlt = 0 max getTerrainHeightASL _posExpect;
private _cosAOA = (vectorDir _vehicle) vectorCos (velocity _vehicle);
private _speedStall = getNumber (configFile >> "CfgVehicles" >> (typeOf _vehicle) >> "stallSpeed");

// flight phase check
private _flightphaseOutput = _vehicle getVariable ["orbis_gpws_flightPhaseParam", ["taxing", 0, 0, 0]];
private _flightphase = _flightphaseOutput select 0;

// incoming mssile check (RWR)
private _incomingMSLlist = _vehicle getVariable ["orbis_gpws_incomingMSLlist", []];
private _incomingMSLs = _incomingMSLlist apply {_x select 0};
private _ctrWarnMSLs =_incomingMSLs select {[_vehicle, _x] call orbis_gpws_fnc_isMSLCritical};
private _targetMSLs = _ctrWarnMSLs - _ctrWarnOld;
private _counterGo = {alive _x} count _targetMSLs > 0;
/* private _samGo = false;
{
	if (getPos (_x select 2) select 2 < 10) exitWith {
		_samGo = true;
	};
} forEach _incomingMSLlist; */

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

// hostile radar lock check
/* private _allRadars = (_vehicle nearObjects orbis_gpws_rwrDetectRange) select {isClass (configFile >> "CfgVehicles" >> (typeOf _x) >> "Components" >> "SensorsManagerComponent" >> "Components" >> "ActiveRadarSensorComponent")};
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
if (_vehicle getVariable ["orbis_gpws_GPWSready", true]) then {
	switch (true) do {
		// f16_counter
		case (_counterGo): {
			DEV_CHAT("orbis_gpws: f16_counter");
			_vehicle setVariable ["orbis_gpws_GPWSready", false];
			[_vehicle, "f16_counter"] spawn orbis_gpws_fnc_speakGPWS;
			_ctrWarnOld = _ctrWarnMSLs;
		};

		// f16_jammer
		/* case (_jammerGo): {
			DEV_CHAT("orbis_gpws: f16_jammer");
			_vehicle setVariable ["orbis_gpws_GPWSready", false];
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
			_vehicle setVariable ["orbis_gpws_GPWSready", false];
			[_vehicle, "f16_pullUp"] spawn orbis_gpws_fnc_speakGPWS;
		};

		// f16_altitude (inFlight)
		case ((_altRadar < orbis_gpws_f16LowAltitude) && (_flightphase isEqualTo "inFlight")): {
			DEV_CHAT("orbis_gpws: f16_altitude");
			_vehicle setVariable ["orbis_gpws_GPWSready", false];
			[_vehicle, "f16_altitude"] spawn orbis_gpws_fnc_speakGPWS;
		};

		// f16_warning
		case ((_damageNow > orbis_gpws_warningDamageLevel) && (_damageWarnLevel < 2)): {
			DEV_CHAT("orbis_gpws: f16_warning");
			_vehicle setVariable ["orbis_gpws_GPWSready", false];
			[_vehicle, "f16_warning"] spawn orbis_gpws_fnc_speakGPWS;
			_vehicle setVariable ["orbis_gpws_damageWarnLevel", 2];
		};

		// f16_caution
		case ((_damageNow > orbis_gpws_cautionDamageLevel) && (_damageWarnLevel < 1)): {
			DEV_CHAT("orbis_gpws: f16_caution");
			_vehicle setVariable ["orbis_gpws_GPWSready", false];
			[_vehicle, "f16_caution"] spawn orbis_gpws_fnc_speakGPWS;
			_vehicle setVariable ["orbis_gpws_damageWarnLevel", 1];
		};

		// f16_bingo
		case ((fuel _vehicle < orbis_gpws_f16BingoFuel) && !(_vehicle getVariable ["bingoAlerted", false])): {
			DEV_CHAT("orbis_gpws: f16_bingo");
			_vehicle setVariable ["orbis_gpws_GPWSready", false];
			[_vehicle, "f16_bingo"] spawn orbis_gpws_fnc_speakGPWS;
			_vehicle setVariable ["bingoAlerted", true];
		};

		default {};
	};
};

// GPWS beep
if (_vehicle getVariable ["orbis_gpws_GPWSreadyBeep", true]) then {
	switch (true) do {
		// f16_SAM
		/* case (_samGo): {
			DEV_CHAT("orbis_gpws: f16_SAM");
			_vehicle setVariable ["orbis_gpws_GPWSreadyBeep", false];
			[_vehicle, "f16_SAM", nil, nil, "orbis_gpws_GPWSreadyBeep"] spawn orbis_gpws_fnc_speakGPWS;
			_samGo = false;
		}; */

		// f16_lowSpeed
		case ((speed _vehicle < _speedStall) && !(isTouchingGround _vehicle)): {
			DEV_CHAT("orbis_gpws: f16_lowSpeed");
			_vehicle setVariable ["orbis_gpws_GPWSreadyBeep", false];
			[_vehicle, "f16_lowSpeed", nil, nil, "orbis_gpws_GPWSreadyBeep"] spawn orbis_gpws_fnc_speakGPWS;
		};

		// f16_highAOA
		case ((_cosAOA < cos orbis_gpws_f16MaxAOA) && (speed _vehicle > 50)): {
			DEV_CHAT("orbis_gpws: f16_highAOA");
			_vehicle setVariable ["orbis_gpws_GPWSreadyBeep", false];
			[_vehicle, "f16_highAOA", nil, nil, "orbis_gpws_GPWSreadyBeep"] spawn orbis_gpws_fnc_speakGPWS;
		};

		default {};
	};
};

_vehicle setVariable ["orbis_gpws_f16Data", [time, _ctrWarnOld, _target/* , _targetOld */]];
