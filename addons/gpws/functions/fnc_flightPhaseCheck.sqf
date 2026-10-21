#include "script_component.hpp"
#include "header_macros.hpp"

params ["_vehicle", ["_flightphase", "taxiing"], ["_currentILSindex", -1]];
private ["_headingDiff", "_approachAngle", "_ILSarray"];
private _fnc_angleDiff = {abs ((((_this select 0) - (_this select 1)) + 540) % 360 - 180)};
private _altAGLS = getPos _vehicle select 2;
private _altASLW = getPosASLW _vehicle select 2;
private _altRadar = _altAGLS min _altASLW;
private _altASL = getPosASL _vehicle select 2;
private _climbASL = velocity _vehicle select 2; // m/s
private _flapStatus = _vehicle animationSourcePhase "flap";
private _gearStatus = _vehicle animationSourcePhase "gear";
private _distance = 10000;
private _distanceReturn = 10000;
private _altDiff = _altRadar;
private _altDiffReturn = _altRadar;
private _altDiffDesired = _altRadar;

switch (_flightphase) do {
	case ("taxiing"): {
		if (speed _vehicle > 80) then {
			_flightphase = "takeOff";
			DEV_CHAT("orbis_gpws: b747GPWS taxiing -> takeOff");
		};
	};
	case ("takeOff"): {
		if ((_altRadar > GVAR(takeoffAlt)) || (speed _vehicle > GVAR(takeoffSpeed))) then {
			_flightphase = "inFlight";
			DEV_CHAT("orbis_gpws: b747GPWS takeOff -> inFlight");
		};

		if (isTouchingGround _vehicle) exitWith {
			_flightphase = "touchDown";
			DEV_CHAT("orbis_gpws: b747GPWS takeOff -> touchDown");
		};
	};
	case ("inFlight"): {
		_currentILSindex = -1;

		if (isTouchingGround _vehicle) exitWith {
			_flightphase = "touchDown";
			DEV_CHAT("orbis_gpws: b747GPWS inFlight -> touchDown");
		};

		{
			_altDiff = _altASL - (_x select 0 select 2);
			_distance = (_x select 0) distance2D (getPos _vehicle);
			_headingDiff = [getDir _vehicle, _x select 1] call _fnc_angleDiff;
			_approachAngle = [(getPos _vehicle) getDir (_x select 0), _x select 1] call _fnc_angleDiff;
			if ((speed _vehicle < 600) && (_altDiff < 400) && (_distance < 6000) && (_headingDiff < 30) && (_approachAngle < 30) && (_climbASL < 0)) exitWith {
				_flightphase = "landing";
				_currentILSindex = _forEachIndex;
				DEV_CHAT("orbis_gpws: b747GPWS inFlight -> landing (ILS app.)");
			};
		} forEach GVAR(runwayList);

		if !(_currentILSindex < 0) exitWith {};

		if ((speed _vehicle < 600) && ((_flapStatus > 0.1) || (_gearStatus < 0.9)) && (_altRadar < 400) && (_climbASL < 0)) exitWith {
			_flightphase = "landing";
			_currentILSindex = -1;
			DEV_CHAT("orbis_gpws: b747GPWS inFlight -> landing (visual app.)");
		};
	};
	case ("landing"): {
		if !(_currentILSindex < 0) then {
			_ILSarray = GVAR(runwayList) select _currentILSindex;
			_altDiff = _altASL - (_ILSarray select 0 select 2);
			_distance = (_ILSarray select 0) distance2D (getPos _vehicle);
			_distanceReturn = _distance;
			_altDiffReturn = _altDiff;
			_altDiffDesired = _distance * tan (_ILSarray select 2);
			_headingDiff = [getDir _vehicle, _ILSarray select 1] call _fnc_angleDiff;
			_approachAngle = [(getPos _vehicle) getDir (_ILSarray select 0), _ILSarray select 1] call _fnc_angleDiff;
			switch (true) do {
				case ((speed _vehicle > 600) || (_altDiff > 400) || (_distance > 6000) || (_headingDiff > 30) || (_approachAngle > 30) || (_climbASL > 5)): {
					_flightphase = "inFlight";
					_currentILSindex = -1;
					DEV_CHAT("orbis_gpws: b747GPWS landing -> inFlight");
				};
				case ((speed _vehicle < 400) && (_altDiff < 100) && (_distance < 1000) && (_headingDiff < 30) && (_approachAngle < 30) && (_climbASL < 0)): {
					_flightphase = "final";
					DEV_CHAT("orbis_gpws: b747GPWS landing -> final (ILS app.)");
				};
				case (isTouchingGround _vehicle): {
					_flightphase = "touchDown";
					DEV_CHAT("orbis_gpws: b747GPWS landing -> touchDown");
				};
				default {};
			};
		} else {
			switch (true) do {
				case ((speed _vehicle > 600) || ((_flapStatus < 0.1) && (_gearStatus > 0.9)) || (_altRadar > 400) || (_climbASL > 5)): {
					_flightphase = "inFlight";
					DEV_CHAT("orbis_gpws: b747GPWS landing -> inFlight");
				};
				case ((speed _vehicle < 400) && ((_flapStatus > 0.6) || (_gearStatus < 0.9)) && (_altRadar < 100) && (_climbASL < 0)): {
					_flightphase = "final";
					DEV_CHAT("orbis_gpws: b747GPWS landing -> final (visual app.)");
				};
				case (isTouchingGround _vehicle): {
					_flightphase = "touchDown";
					DEV_CHAT("orbis_gpws: b747GPWS landing -> touchDown");
				};
				default {
					{
						_altDiff = _altASL - (_x select 0 select 2);
						_distance = (_x select 0) distance2D (getPos _vehicle);
						_headingDiff = [getDir _vehicle, _x select 1] call _fnc_angleDiff;
						_approachAngle = [(getPos _vehicle) getDir (_x select 0), _x select 1] call _fnc_angleDiff;
						if ((_altDiff < 200) && (_distance < 3000) && (_headingDiff < 30) && (_approachAngle < 30)) exitWith {
							_currentILSindex = _forEachIndex;
							_distanceReturn = _distance;
							_altDiffReturn = _altDiff;
							_altDiffDesired = _distance * tan (_x select 2);
							DEV_CHAT("orbis_gpws: b747GPWS ILS capture");
						};
					} forEach GVAR(runwayList);
				};
			};
		};
	};
	case ("final"): {
		if !(_currentILSindex < 0) then {
			_ILSarray = GVAR(runwayList) select _currentILSindex;
			_altDiff = _altASL - (_ILSarray select 0 select 2);
			_distance = (_ILSarray select 0) distance2D (getPos _vehicle);
			_distanceReturn = _distance;
			_altDiffReturn = _altDiff;
			_altDiffDesired = _distance * tan (_ILSarray select 2);
			_headingDiff = [getDir _vehicle, _ILSarray select 1] call _fnc_angleDiff;
			switch (true) do {
				case ((_altDiff > 100) || (_distance > 1000) || (_headingDiff > 30) || (_climbASL > 5)): {
					_flightphase = "inFlight";
					DEV_CHAT("orbis_gpws: b747GPWS final -> inFLight");
				};
				case (isTouchingGround _vehicle): {
					_flightphase = "touchDown";
					DEV_CHAT("orbis_gpws: b747GPWS final -> touchDown");
				};
				default {};
			};
		} else {
			switch (true) do {
				case (((_flapStatus < 0.1) && (_gearStatus > 0.9)) || (_altRadar > 200) || (_climbASL > 5)): {
					_flightphase = "inFlight";
					DEV_CHAT("orbis_gpws: b747GPWS final -> inFlight");
				};
				case (isTouchingGround _vehicle): {
					_flightphase = "touchDown";
					DEV_CHAT("orbis_gpws: b747GPWS final -> touchDown");
				};
				default {
					{
						_altDiff = _altASL - (_x select 0 select 2);
						_distance = (_x select 0) distance2D (getPos _vehicle);
						_headingDiff = [getDir _vehicle, _x select 1] call _fnc_angleDiff;
						_approachAngle = [(getPos _vehicle) getDir (_x select 0), _x select 1] call _fnc_angleDiff;
						if ((_altDiff < 100) && (_distance < 1000) && (_headingDiff < 30)) exitWith {
							_currentILSindex = _forEachIndex;
							_distanceReturn = _distance;
							_altDiffReturn = _altDiff;
							_altDiffDesired = _distance * tan (_x select 2);
							DEV_CHAT("orbis_gpws: b747GPWS ILS capture");
						};
					} forEach GVAR(runwayList);
				};
			};
		};
	};
	case ("touchDown"): {
		switch (true) do {
			case (_altRadar > GVAR(takeoffAlt)): {
				_flightphase = "inFlight";
				DEV_CHAT("orbis_gpws: b747GPWS touchDown -> inFlight");
			};
			case (speed _vehicle < 50): {
				_flightphase = "taxiing";
				DEV_CHAT("orbis_gpws: b747GPWS touchDown -> taxiing");
			};
			default {};
		};
	};
	default {};
};

if (_flightphase in ["taxiing", "takeOff", "inFlight", "touchDown"]) then {
	_currentILSindex = -1;
};

[_flightphase, _distanceReturn, _altDiffReturn, _altDiffDesired, _currentILSindex];
