#include "header_macros.hpp"

params ["_vehicle", "_flightphase", "_altRadar", "_climeASL", "_flapStatus", "_gearStatus"];
private ["_headingDiff", "_approachAngle", "_ILSarray", "_currentILSindex"];
private _currentILSindex = -1;
private _distance = 10000;
private _distanceReturn = 10000;
private _altDiff = _altRadar;
private _altDiffReturn = _altRadar;
private _altDiffDesired = _altRadar;

switch (_flightphase) do {
    case ("taxing"): {
        if (speed _vehicle > 80) then {
            _flightphase = "takeOff";
            DEV_CHAT("orbis_gpws: b747GPWS taxing -> takeOff");
        };
    };
    case ("takeOff"): {
        if (_altRadar > orbis_gpws_takeoffAlt) then {
            _flightphase = "inFlight";
            DEV_CHAT("orbis_gpws: b747GPWS takeOff -> inFlight");
        };
    };
    case ("inFlight"): {
        {
            _altDiff = _altASL - (_x select 0 select 2);
            _distance = (_x select 0) distance2D (getPos _vehicle);
            _headingDiff = abs ((getDir _vehicle) - (_x select 1));
            _approachAngle = abs (((getPos _vehicle) getDir (_x select 0)) - (_x select 1));
            if ((speed _vehicle < 600) && (_altDiff < 400) && (_distance < 6000) && (_headingDiff < 30) && (_approachAngle < 30) && (_climeASL < 0)) exitWith {
                _flightphase = "landing";
                _currentILSindex = _forEachIndex;
                DEV_CHAT("orbis_gpws: b747GPWS inFlight -> landing (ILS app.)");
            };
        } forEach orbis_gpws_runwayList;

        if ((speed _vehicle < 600) && (_flapStatus > 0.1) && (_gearStatus < 0.9) && (_altRadar < 400) && (_climeASL < 0)) then {
            _flightphase = "landing";
            _currentILSindex = -1;
            DEV_CHAT("orbis_gpws: b747GPWS inFlight -> landing (visual app.)");
        };
    };
    case ("landing"): {
        if (_currentILSindex > -1) then {
            _ILSarray = orbis_gpws_runwayList select _currentILSindex;
            _altDiff = _altASL - (_ILSarray select 0 select 2);
            _distance = (_ILSarray select 0) distance2D (getPos _vehicle);
            _distanceReturn = _distance;
            _altDiffReturn = _altDiff;
            _altDiffDesired = _distance * tan (_ILSarray select 2);
            _headingDiff = abs ((getDir _vehicle) - (_ILSarray select 1));
            _approachAngle = abs (((getPos _vehicle) getDir (_ILSarray select 0)) - (_ILSarray select 1));
            switch (true) do {
                case ((speed _vehicle > 600) || (_altDiff > 400) || (_distance > 6000) || (_headingDiff > 30) || (_approachAngle > 30) || (_climeASL > 5)): {
                    _flightphase = "inFlight";
                    _currentILSindex = -1;
                    DEV_CHAT("orbis_gpws: b747GPWS landing -> inFlight");
                };
                case ((speed _vehicle < 400) && (_altDiff < 100) && (_distance < 1000) && (_headingDiff < 30) && (_approachAngle < 30) && (_climeASL < 0)): {
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
                case ((speed _vehicle > 600) || (_flapStatus < 0.1) || (_gearStatus > 0.9) || (_altRadar > 400) || (_climeASL > 5)): {
                    _flightphase = "inFlight";
                    DEV_CHAT("orbis_gpws: b747GPWS landing -> inFlight");
                };
                case ((speed _vehicle < 400) && (_flapStatus > 0.6) && (_gearStatus < 0.9) && (_altRadar < 100) && (_climeASL < 0)): {
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
                        _headingDiff = abs ((getDir _vehicle) - (_x select 1));
                        _approachAngle = abs (((getPos _vehicle) getDir (_x select 0)) - (_x select 1));
                        if ((_altDiff < 200) && (_distance < 3000) && (_headingDiff < 30) && (_approachAngle < 30)) exitWith {
                            _currentILSindex = _forEachIndex;
                            _distanceReturn = _distance;
                            _altDiffReturn = _altDiff;
                            _altDiffDesired = _distance * tan (_x select 2);
                            DEV_CHAT("orbis_gpws: b747GPWS ILS capture");
                        };
                    } forEach orbis_gpws_runwayList;
                };
            };
        };
    };
    case ("final"): {
        if (_currentILSindex > -1) then {
            _ILSarray = orbis_gpws_runwayList select _currentILSindex;
            _altDiff = _altASL - (_ILSarray select 0 select 2);
            _distance = (_ILSarray select 0) distance2D (getPos _vehicle);
            _distanceReturn = _distance;
            _altDiffReturn = _altDiff;
            _altDiffDesired = _distance * tan (_ILSarray select 2);
            _headingDiff = abs ((getDir _vehicle) - (_ILSarray select 1));
            switch (true) do {
                case ((_altDiff > 100) || (_distance > 1000) || (_headingDiff > 30) || (_climeASL > 5)): {
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
                case ((_flapStatus < 0.1) || (_gearStatus > 0.9) || (_altRadar > 200) || (_climeASL > 5)): {
                    _flightphase = "inFlight";
                    DEV_CHAT("orbis_gpws: b747GPWS landing -> inFlight");
                };
                case (isTouchingGround _vehicle): {
                    _flightphase = "touchDown";
                    DEV_CHAT("orbis_gpws: b747GPWS landing -> touchDown");
                };
                default {
                    {
                        _altDiff = _altASL - (_x select 0 select 2);
                        _distance = (_x select 0) distance2D (getPos _vehicle);
                        _headingDiff = abs ((getDir _vehicle) - (_x select 1));
                        _approachAngle = abs (((getPos _vehicle) getDir (_x select 0)) - (_x select 1));
                        if ((_altDiff < 100) && (_distance < 1000) && (_headingDiff < 30)) exitWith {
                            _currentILSindex = _forEachIndex;
                            _distanceReturn = _distance;
                            _altDiffReturn = _altDiff;
                            _altDiffDesired = _distance * tan (_x select 2);
                            DEV_CHAT("orbis_gpws: b747GPWS ILS capture");
                        };
                    } forEach orbis_gpws_runwayList;
                };
            };
        };
    };
    case ("touchDown"): {
        switch (true) do {
            case (_altRadar > orbis_gpws_takeoffAlt): {
                _flightphase = "inFlight";
                DEV_CHAT("orbis_gpws: b747GPWS touchDown -> inFlight");
            };
            case (speed _vehicle < 50): {
                _flightphase = "taxing";
                DEV_CHAT("orbis_gpws: b747GPWS touchDown -> taxing");
            };
            default {};
        };
    };
    default {};
};

[_flightphase, _distanceReturn, _altDiff, _altDiffDesired];
