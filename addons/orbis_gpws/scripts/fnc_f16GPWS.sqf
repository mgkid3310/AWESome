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
	"_posExpect", "_cosAOA", "_flapStatus", "_gearStatus", "_acceleration", "_climeASL", "_climeRadar",
	"_altDiff", "_distance", "_headingDiff", "_approachAngle", "_ILSarray", "_currentILSindex",
	"_incomingMSLlist", "_incomingMSLs", "_ctrWarnMSLs", "_targetMSLs", "_counterGo"/* ,
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
	switch (_flightphase) do {
		case ("taxing"): {
			if (speed _vehicle > 80) then {
				_flightphase = "takeOff";
				DEV_CHAT("orbis_gpws: f16GPWS taxing -> takeOff");
			};
		};
		case ("takeOff"): {
			if (_altRadar > orbis_gpws_takeoffAlt) then {
				_flightphase = "inFlight";
				DEV_CHAT("orbis_gpws: f16GPWS takeOff -> inFlight");
			};
		};
		case ("inFlight"): {
			{
				_altDiff = _altASL - (_x select 0 select 2);
				_distance = (_x select 0) distance2D (getPos _vehicle);
				_headingDiff = abs ((getDir _vehicle) - (_x select 1));
				_approachAngle = abs (((getPos _vehicle) getDir (_x select 0)) - (_x select 1));
				if ((_altDiff < 200) && (_distance < 3000) && (_headingDiff < 30) && (_approachAngle < 30)) exitWith {
					_flightphase = "landing";
					_currentILSindex = _forEachIndex;
					DEV_CHAT("orbis_gpws: f16GPWS inFlight -> landing (ILS)");
				};
			} forEach orbis_gpws_runwayList;

			if ((_flapStatus > 0.1) && (_gearStatus < 0.9) && (_altRadar < 200) && (_climeASL < 0)) then {
				_flightphase = "landing";
				_currentILSindex = 0;
				DEV_CHAT("orbis_gpws: f16GPWS inFlight -> landing");
			};
		};
		case ("landing"): {
			if (_currentILSindex > 0) then {
				_ILSarray = orbis_gpws_runwayList select _currentILSindex;
				_altDiff = _altASL - (_ILSarray select 0 select 2);
				_distance = (_ILSarray select 0) distance2D (getPos _vehicle);
				_headingDiff = abs ((getDir _vehicle) - (_ILSarray select 1));
				_approachAngle = abs (((getPos _vehicle) getDir (_ILSarray select 0)) - (_ILSarray select 1));
				switch (true) do {
					case ((_altDiff > 200) || (_distance > 3000) || (_headingDiff > 30) || (_approachAngle > 30)): {
						_flightphase = "inFlight";
						_currentILSindex = 0;
						DEV_CHAT("orbis_gpws: f16GPWS landing -> inFlight (ILS)");
					};
					case ((_altDiff < 100) && (_distance < 1000) && (_headingDiff < 30) && (_approachAngle < 30)): {
						_flightphase = "final";
						DEV_CHAT("orbis_gpws: f16GPWS landing -> final (ILS)");
					};
					case (isTouchingGround _vehicle): {
						_flightphase = "touchDown";
						DEV_CHAT("orbis_gpws: f16GPWS landing -> touchDown (ILS)");
					};
					default {};
				};
			} else {
				switch (true) do {
					case ((_flapStatus < 0.1) || (_gearStatus > 0.9) || (_altRadar > 200) || (_climeASL > 3)): {
						_flightphase = "inFlight";
						DEV_CHAT("orbis_gpws: f16GPWS landing -> inFlight");
					};
					case ((_flapStatus > 0.6) && (_gearStatus < 0.9) && (_altRadar < 100) && (_climeASL < 0)): {
						_flightphase = "final";
						DEV_CHAT("orbis_gpws: f16GPWS landing -> final");
					};
					case (isTouchingGround _vehicle): {
						_flightphase = "touchDown";
						DEV_CHAT("orbis_gpws: f16GPWS landing -> touchDown");
					};
					default {};
				};
			};
		};
		case ("final"): {
			if (_currentILSindex > 0) then {
				_ILSarray = orbis_gpws_runwayList select _currentILSindex;
				_altDiff = _altASL - (_ILSarray select 0 select 2);
				_distance = (_ILSarray select 0) distance2D (getPos _vehicle);
				_headingDiff = abs ((getDir _vehicle) - (_ILSarray select 1));
				switch (true) do {
					case ((_altDiff > orbis_gpws_takeoffAlt) || (_distance > 1000) || (_headingDiff > 30)): {
						_flightphase = "inFlight";
						DEV_CHAT("orbis_gpws: f16GPWS final -> inFLight (ILS)");
					};
					case (isTouchingGround _vehicle): {
						_flightphase = "touchDown";
						DEV_CHAT("orbis_gpws: f16GPWS final -> touchDown (ILS)");
					};
					default {};
				};
			} else {
				switch (true) do {
					case ((_flapStatus < 0.1) || (_gearStatus > 0.9) || (_altRadar > 200) || (_climeASL > 3)): {
						_flightphase = "inFlight";
						DEV_CHAT("orbis_gpws: f16GPWS landing -> inFlight");
					};
					case (isTouchingGround _vehicle): {
						_flightphase = "touchDown";
						DEV_CHAT("orbis_gpws: f16GPWS landing -> touchDown");
					};
					default {};
				};
			};
		};
		case ("touchDown"): {
			switch (true) do {
				case (_altRadar > orbis_gpws_takeoffAlt): {
					_flightphase = "inFlight";
					DEV_CHAT("orbis_gpws: f16GPWS touchDown -> inFlight");
				};
				case (speed _vehicle < 50): {
					_flightphase = "taxing";
					DEV_CHAT("orbis_gpws: f16GPWS touchDown -> taxing");
				};
				default {};
			};
		};
		default {};
	};

	// incoming mssile check (RWR)
	_incomingMSLlist = _vehicle getVariable ["incomingMSLlist", []];
	_incomingMSLs = _incomingMSLlist apply {_x select 0};
	_ctrWarnMSLs =_incomingMSLs select {(_vehicle distance _x) < (orbis_gpsw_mslApproachTime * vectorMagnitude (velocity _vehicle vectorDiff velocity _x))};
	_targetMSLs = _ctrWarnMSLs - _ctrWarnOld;
	_counterGo = {alive _x} count _targetMSLs > 0;
	/* {
		if (getPos (_x select 2) select 2 < 10) exitWith {
			_samGo = true;
		};
	} forEach _incomingMSLlist; */

	// hostile radar lock check
	/* private _allRadars = (_vehicle nearObjects orbis_gpsw_rwrDetectRange) select {isClass (configFile >> "CfgVehicles" >> (typeOf _x) >> "Components" >> "SensorsManagerComponent" >> "Components" >> "ActiveRadarSensorComponent")};
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
				[_vehicle, "f16_counter", 0.67] spawn orbis_gpws_fnc_speakGPWS;
				_ctrWarnOld = _ctrWarnMSLs;
			};

			// f16_jammer
			/* case (_jammerGo): {
				DEV_CHAT("orbis_gpws: f16_jammer");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "f16_jammer", 0.54] spawn orbis_gpws_fnc_speakGPWS;
				_vehicle setVariable ["radarLocks", _targeting];
			}; */

			// f16_IFF
			/* case (_IFFgo): {
				DEV_CHAT("orbis_gpws: f16_IFF");
				[_vehicle, "f16_IFF", 0.97] spawn orbis_gpws_fnc_speakGPWS;
				_IFFgo = false;
			}; */

			// f16_pullUp (in-flight)
			case (((0 max getTerrainHeightASL _posExpect) > (_posExpect select 2)) && (_flightphase isEqualTo "inFlight")): {
				DEV_CHAT("orbis_gpws: f16_pullUp");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "f16_pullUp", 1.58] spawn orbis_gpws_fnc_speakGPWS;
			};

			// f16_altitude (in-flight)
			case ((_altRadar < orbis_gpws_lowAltitude) && (_flightphase isEqualTo "inFlight")): {
				DEV_CHAT("orbis_gpws: f16_altitude");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "f16_altitude", 2.14] spawn orbis_gpws_fnc_speakGPWS;
			};

			// f16_bingo
			case ((fuel _vehicle < orbis_gpws_bingoFuel) && !(_vehicle getVariable ["bingoAlerted", false])): {
				DEV_CHAT("orbis_gpws: f16_bingo");
				_vehicle setVariable ["orbisGPWSready", false];
				[_vehicle, "f16_bingo", 1.73] spawn orbis_gpws_fnc_speakGPWS;
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
				[_vehicle, "f16_SAM", 0.80, "orbisGPWSreadyBeep"] spawn orbis_gpws_fnc_speakGPWS;
				_samGo = false;
			}; */

			// f16_lowSpeed
			case ((speed _vehicle < _speedStall) && !(isTouchingGround _vehicle)): {
				DEV_CHAT("orbis_gpws: f16_lowSpeed");
				_vehicle setVariable ["orbisGPWSreadyBeep", false];
				[_vehicle, "f16_lowSpeed", 1.50, "orbisGPWSreadyBeep"] spawn orbis_gpws_fnc_speakGPWS;
			};

			// f16_highAOA
			case ((_cosAOA < cos orbis_gpws_maxAOA) && (speed _vehicle > 50)): {
				DEV_CHAT("orbis_gpws: f16_highAOA");
				_vehicle setVariable ["orbisGPWSreadyBeep", false];
				[_vehicle, "f16_highAOA", 0.999, "orbisGPWSreadyBeep"] spawn orbis_gpws_fnc_speakGPWS;
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
_vehicle setVariable ["orbisGPWSmode", ""];
DEV_CHAT("orbis_gpws: f16GPWS ended");

// f16_caution 1.90
// f16_data 0.42
// f16_lock 0.61
// f16_warning 2.20
