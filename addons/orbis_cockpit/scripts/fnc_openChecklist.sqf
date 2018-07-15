private _className = _this select 0;

orbis_cockpit_landingSpeed = (250 / 463) * getNumber (configFile >> 'CfgVehicles' >> (typeOf vehicle player) >> 'landingSpeed');
orbis_cockpit_currentChecklist = _className;
230 cutRsc [_className, "PLAIN"];
