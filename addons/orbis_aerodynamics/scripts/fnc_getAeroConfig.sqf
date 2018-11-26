private _vehicle = _this select 0;

private ["_isAdvanced", "_dragArray", "_liftArray", "_torqueXCoef", "_speedMax", "_speedStall", "_angleOfIndicence", "_effectiveAngle", "_massStandard"];
private _className = typeOf _vehicle;
private _class = (configFile >> "CfgVehicles" >> _className);

// need to find out more
_isAdvanced = toLower getText (_class >> "simulation") isEqualTo "planex";
if (_isAdvanced) then {
    _dragArray = [getArray (_class >> "airFrictionCoefs2"), getArray (_class >> "airFrictionCoefs1"), getArray (_class >> "airFrictionCoefs0")];
} else {
    _dragArray = [getArray (_class >> "airFrictionCoefs2"), getArray (_class >> "airFrictionCoefs1"), getArray (_class >> "airFrictionCoefs0")];
};

_liftArray = getArray (_class >> "envelope");
if (isNumber (_class >> "draconicTorqueXCoef")) then {
    _torqueXCoef = getNumber (_class >> "draconicTorqueXCoef");
} else {
    _torqueXCoef = getArray (_class >> "draconicTorqueXCoef");
};
_speedMax = getNumber (_class >> "maxSpeed");
_speedStall = getNumber (_class >> "stallSpeed");
_angleOfIndicence = getNumber (_class >> "angleOfIndicence");
_effectiveAngle = _angleOfIndicence / 2;
_massStandard = getMass _vehicle;
if !(_massStandard > 0) then {
    _massStandard = 1000;
};

private _return = [_isAdvanced, _dragArray, _liftArray, _torqueXCoef, [_speedMax, _speedStall, _angleOfIndicence, _effectiveAngle, _massStandard]];

// report if needed (dev script)
// diag_log format ["orbis_aerodynamics aeroConfig: %1", _return];

_return
