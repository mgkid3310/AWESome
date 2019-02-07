private _className = _this select 0;

awesome_cockpit_landingSpeed = awesome_awesome_kphToKnot * getNumber (configFile >> 'CfgVehicles' >> (typeOf vehicle player) >> 'landingSpeed');
awesome_cockpit_lastChecklist = awesome_cockpit_currentChecklist;
awesome_cockpit_currentChecklist = _className;
230 cutRsc [_className, "PLAIN"];
