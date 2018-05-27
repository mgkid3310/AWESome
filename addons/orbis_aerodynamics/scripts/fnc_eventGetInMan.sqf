private _vehicle = _this select 0;

_vehicle addEventHandler ["LandedTouchDown", {_this call orbis_aerodynamics_fnc_eventTouchdown}];
