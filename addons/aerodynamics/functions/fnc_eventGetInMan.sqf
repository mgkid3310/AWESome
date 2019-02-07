private _vehicle = _this select 2;

_vehicle addEventHandler ["LandedTouchDown", {_this call awesome_aerodynamics_fnc_eventTouchdown}];
