#include "script_component.hpp"
#include "header_macros.hpp"

params ["_vehicle"];

private _loadData = _vehicle getVariable [QGVAR(b747Data), [time, [], false, false, 0]];
_loadData params ["_timeOld", "_criticalWarningLog", "_gearWarned", "_flapsWarned", "_bankWarnTime"];

if !(_timeOld < time) exitWith {
	_vehicle setVariable [QGVAR(b747Data), _loadData];
};

// flight status check
private _altAGLS = getPos _vehicle select 2;
private _altASL = getPosASL _vehicle select 2;
private _altRadar = _altAGLS min _altASL;
private _posExpect = (getPosASL _vehicle) vectorAdd (velocity _vehicle vectorMultiply GVAR(posExpectTime));
private _expectTerrainAlt = 0 max getTerrainHeightASL _posExpect;
private _flapStatus = _vehicle animationSourcePhase "flap";
private _gearStatus = _vehicle animationSourcePhase "gear";
private _climeASL = velocity _vehicle select 2; // m/s

private _pitchAndBank = _vehicle call BIS_fnc_getPitchBank;
private _pitchAngle = _pitchAndBank select 0;
private _bankAngle = _pitchAndBank select 1;

// flight phase check
private _flightphaseOutput = _vehicle getVariable [QGVAR(flightPhaseParam), ["taxing", 0, 0, 0]];
private _flightphase = _flightphaseOutput select 0;
private _distance = _flightphaseOutput select 1;
private _altDiff = _flightphaseOutput select 2;
private _altDiffDesired = _flightphaseOutput select 3;

private _tooLow = !(_flightphase in ["taxing", "takeOff", "touchDown"]) && (_altRadar < GVAR(tooLowAlt));
private _terrainWarn = (_altRadar > 5) && (_flightphase in ["takeOff", "inFlight", "landing"]) && ((_expectTerrainAlt + GVAR(terrainWarningHeight)) > _altASL);
private _dontSink = (_flightphase isEqualTo "takeOff") && (_altRadar > 5) && (_altRadar < 100) && (_climeASL < 0);
private _sinkRate = _climeASL < GVAR(maxSinkRate);
private _isCritical = _terrainWarn || _dontSink || _sinkRate;

if !(_tooLow) then {
	if (_flapsWarned) then {
		_flapsWarned = false;
	};
	if (_gearWarned) then {
		_gearWarned = false;
	};
};

private _minWarnLevel = _vehicle getVariable [QGVAR(minWarnLevel), 0];
switch (_minWarnLevel) do {
	case (2): {
		if (_altRadar > ((GVAR(minAlt) + 50) * EGVAR(main,ftToM))) then {
			_minWarnLevel = 1;
			_vehicle setVariable [QGVAR(minWarnLevel), 1];
		};
		if (_altRadar > ((GVAR(appMinAlt) + 50) * EGVAR(main,ftToM))) then {
			_minWarnLevel = 0;
			_vehicle setVariable [QGVAR(minWarnLevel), 0];
		};
	};
	case (1): {
		if (_altRadar > ((GVAR(appMinAlt) + 50) * EGVAR(main,ftToM))) then {
			_minWarnLevel = 0;
			_vehicle setVariable [QGVAR(minWarnLevel), 0];
		};
	};
	default {};
};

// altInfo saves minimum altitude informed
_altInfo = _vehicle getVariable [QGVAR(altInformLevel), 2000];
if ((_altInfo == 10) && (_altRadar > (15 * EGVAR(main,ftToM)))) then {
	_altInfo = 20;
};
if ((_altInfo == 20) && (_altRadar > (25 * EGVAR(main,ftToM)))) then {
	_altInfo = 30;
};
if ((_altInfo == 30) && (_altRadar > (35 * EGVAR(main,ftToM)))) then {
	_altInfo = 40;
};
if ((_altInfo == 40) && (_altRadar > (45 * EGVAR(main,ftToM)))) then {
	_altInfo = 50;
};
if ((_altInfo == 50) && (_altRadar > (75 * EGVAR(main,ftToM)))) then {
	_altInfo = 100;
};
if ((_altInfo == 100) && (_altRadar > (150 * EGVAR(main,ftToM)))) then {
	_altInfo = 200;
};
if ((_altInfo == 200) && (_altRadar > (250 * EGVAR(main,ftToM)))) then {
	_altInfo = 300;
};
if ((_altInfo == 300) && (_altRadar > (350 * EGVAR(main,ftToM)))) then {
	_altInfo = 400;
};
if ((_altInfo == 400) && (_altRadar > (450 * EGVAR(main,ftToM)))) then {
	_altInfo = 500;
};
if ((_altInfo == 500) && (_altRadar > (600 * EGVAR(main,ftToM)))) then {
	_altInfo = 1000;
};
if ((_altInfo == 1000) && (_altRadar > (1200 * EGVAR(main,ftToM)))) then {
	_altInfo = 2000;
};
_vehicle setVariable [QGVAR(altInformLevel), _altInfo];

// GPWS general speech work
if ((_vehicle getVariable [QGVAR(nextGPWStime), -1]) < time) then {

	// log & update critical warnings
	if (_terrainWarn || _dontSink || _sinkRate) then {
		_criticalWarningLog pushBack time;
	};
	_criticalWarningLog = _criticalWarningLog select {(_x + GVAR(pullupLogTime)) > time};

	// run speech
	switch (true) do {
		// b747_PULLUP (inFlight)
		case (_isCritical && (count _criticalWarningLog > 2)): {
			DEV_CHAT("orbis_gpws: b747_PULLUP");
			[_vehicle, "b747_PULLUP", GVAR(b747Delay)] call FUNC(speakGPWS);
		};

		// b747_TOOLOWT (takeOff / inFlight / landing)
		case (_tooLow && _terrainWarn): {
			DEV_CHAT("orbis_gpws: b747_TOOLOWT");
			[_vehicle, "b747_TOOLOWT", GVAR(b747Delay)] call FUNC(speakGPWS);
		};

		// b747_TERRAIN (takeOff / inFlight / landing)
		case (_terrainWarn): {
			DEV_CHAT("orbis_gpws: b747_TERRAIN");
			[_vehicle, "b747_TERRAIN", GVAR(b747Delay)] call FUNC(speakGPWS);
		};

		// b747_DONTSNK (takeOff)
		case (_dontSink): {
			DEV_CHAT("orbis_gpws: b747_DONTSNK");
			[_vehicle, "b747_DONTSNK", GVAR(b747Delay)] call FUNC(speakGPWS);
		};

		// b747_SNKRATE
		case (_sinkRate): {
			DEV_CHAT("orbis_gpws: b747_SNKRATE");
			[_vehicle, "b747_SNKRATE", GVAR(b747Delay)] call FUNC(speakGPWS);
		};

		// b747_BNKANGL
		case ((_bankWarnTime + 5 < time) && (abs _bankAngle > GVAR(maxBankAngle))): {
			DEV_CHAT("orbis_gpws: b747_BNKANGL");
			[_vehicle, "b747_BNKANGL", GVAR(b747Delay)] call FUNC(speakGPWS);
			_bankWarnTime = time;
		};

		// b747_FLAPS (inFlight, landing, final)
		case (_tooLow && !_flapsWarned && (_flightphase in ["inFlight", "landing", "final"]) && (_flapStatus < 0.1)): {
			DEV_CHAT("orbis_gpws: b747_FLAPS");
			[_vehicle, "b747_FLAPS", GVAR(b747Delay)] call FUNC(speakGPWS);
			_flapsWarned = true;
		};

		// b747_GEAR (inFlight, landing, final)
		case (_tooLow && !_gearWarned && (_flightphase in ["inFlight", "landing", "final"]) && (_gearStatus > 0.9)): {
			DEV_CHAT("orbis_gpws: b747_GEAR");
			[_vehicle, "b747_GEAR", GVAR(b747Delay)] call FUNC(speakGPWS);
			_gearWarned = true;
		};

		// b747_GLIDESLOPE (landing, final)
		case ((_flightphase in ["landing", "final"]) && (((_altDiffDesired - 50) min (_altDiffDesired * 0.8)) > _altDiff)): {
			DEV_CHAT("orbis_gpws: b747_GLIDESLOPE");
			[_vehicle, "b747_GLIDESLOPE", GVAR(b747Delay)] call FUNC(speakGPWS);
		};

		// b747_MIN (landing / final)
		case ((_flightphase in ["landing", "final"]) && (_altRadar < (GVAR(minAlt) * EGVAR(main,ftToM))) && (_minWarnLevel < 2) && (_climeASL < 0)): {
			DEV_CHAT("orbis_gpws: b747_MIN");
			[_vehicle, "b747_MIN"] call FUNC(speakGPWS);
			_vehicle setVariable [QGVAR(minWarnLevel), 2];
		};

		// b747_APPRMIN (landing / final)
		case ((_flightphase in ["landing", "final"]) && (_altRadar < (GVAR(appMinAlt) * EGVAR(main,ftToM))) && (_minWarnLevel < 1) && (_climeASL < 0)): {
			DEV_CHAT("orbis_gpws: b747_APPRMIN");
			[_vehicle, "b747_APPRMIN"] call FUNC(speakGPWS);
			_vehicle setVariable [QGVAR(minWarnLevel), 1];
		};

		// b747_10 (landing / final)
		case ((_flightphase in ["landing", "final"]) && (_altRadar < (10 * EGVAR(main,ftToM))) && (_altInfo > 10) && (_climeASL < 0)): {
			DEV_CHAT("orbis_gpws: b747_10");
			[_vehicle, "b747_10"] call FUNC(speakGPWS);
			_vehicle setVariable [QGVAR(altInformLevel), 10];
		};

		// b747_20 (landing / final)
		case ((_flightphase in ["landing", "final"]) && (_altRadar < (20 * EGVAR(main,ftToM))) && (_altInfo > 20) && (_climeASL < 0)): {
			DEV_CHAT("orbis_gpws: b747_20");
			[_vehicle, "b747_20"] call FUNC(speakGPWS);
			_vehicle setVariable [QGVAR(altInformLevel), 20];
		};

		// b747_30 (landing / final)
		case ((_flightphase in ["landing", "final"]) && (_altRadar < (30 * EGVAR(main,ftToM))) && (_altInfo > 30) && (_climeASL < 0)): {
			DEV_CHAT("orbis_gpws: b747_30");
			[_vehicle, "b747_30"] call FUNC(speakGPWS);
			_vehicle setVariable [QGVAR(altInformLevel), 30];
		};

		// b747_40 (landing / final)
		case ((_flightphase in ["landing", "final"]) && (_altRadar < (40 * EGVAR(main,ftToM))) && (_altInfo > 40) && (_climeASL < 0)): {
			DEV_CHAT("orbis_gpws: b747_40");
			[_vehicle, "b747_40"] call FUNC(speakGPWS);
			_vehicle setVariable [QGVAR(altInformLevel), 40];
		};

		// b747_50 (landing / final)
		case ((_flightphase in ["landing", "final"]) && (_altRadar < (50 * EGVAR(main,ftToM))) && (_altInfo > 50) && (_climeASL < 0)): {
			DEV_CHAT("orbis_gpws: b747_50");
			[_vehicle, "b747_50"] call FUNC(speakGPWS);
			_vehicle setVariable [QGVAR(altInformLevel), 50];
		};

		// b747_100 (landing / final)
		case ((_flightphase in ["landing", "final"]) && (_altRadar < (100 * EGVAR(main,ftToM))) && (_altInfo > 100) && (_climeASL < 0)): {
			DEV_CHAT("orbis_gpws: b747_100");
			[_vehicle, "b747_100"] call FUNC(speakGPWS);
			_vehicle setVariable [QGVAR(altInformLevel), 100];
		};

		// b747_200 (landing / final)
		case ((_flightphase in ["landing", "final"]) && (_altRadar < (200 * EGVAR(main,ftToM))) && (_altInfo > 200) && (_climeASL < 0)): {
			DEV_CHAT("orbis_gpws: b747_200");
			[_vehicle, "b747_200", GVAR(b747Delay)] call FUNC(speakGPWS);
			_vehicle setVariable [QGVAR(altInformLevel), 200];
		};

		// b747_300 (landing / final)
		case ((_flightphase in ["landing", "final"]) && (_altRadar < (300 * EGVAR(main,ftToM))) && (_altInfo > 300) && (_climeASL < 0)): {
			DEV_CHAT("orbis_gpws: b747_300");
			[_vehicle, "b747_300", GVAR(b747Delay)] call FUNC(speakGPWS);
			_vehicle setVariable [QGVAR(altInformLevel), 300];
		};

		// b747_400 (landing / final)
		case ((_flightphase in ["landing", "final"]) && (_altRadar < (400 * EGVAR(main,ftToM))) && (_altInfo > 400) && (_climeASL < 0)): {
			DEV_CHAT("orbis_gpws: b747_400");
			[_vehicle, "b747_400", GVAR(b747Delay)] call FUNC(speakGPWS);
			_vehicle setVariable [QGVAR(altInformLevel), 400];
		};

		// b747_500 (landing / final)
		case ((_flightphase in ["landing", "final"]) && (_altRadar < (500 * EGVAR(main,ftToM))) && (_altInfo > 500) && (_climeASL < 0)): {
			DEV_CHAT("orbis_gpws: b747_500");
			[_vehicle, "b747_500", GVAR(b747Delay)] call FUNC(speakGPWS);
			_vehicle setVariable [QGVAR(altInformLevel), 500];
		};

		// b747_1000 (landing / final)
		case ((_flightphase in ["landing", "final"]) && (_altRadar < (1000 * EGVAR(main,ftToM))) && (_altRadar > (800 * EGVAR(main,ftToM))) && (_altInfo > 1000) && (_climeASL < 0)): {
			DEV_CHAT("orbis_gpws: b747_1000");
			[_vehicle, "b747_1000", GVAR(b747Delay)] call FUNC(speakGPWS);
			_vehicle setVariable [QGVAR(altInformLevel), 1000];
		};

		default {};
	};
};

_vehicle setVariable [QGVAR(b747Data), [time, _criticalWarningLog, _gearWarned, _flapsWarned, _bankWarnTime]];
