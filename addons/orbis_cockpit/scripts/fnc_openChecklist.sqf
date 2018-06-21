private _dialogType = _this select 0;

orbis_cockpit_landingSpeed = (250 / 463) * getNumber (configFile >> 'CfgVehicles' >> (typeOf vehicle player) >> 'landingSpeed');
orbis_cockpit_currentChecklist = _dialogType;
createDialog _dialogType;
