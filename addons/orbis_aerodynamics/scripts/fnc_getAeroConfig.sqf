private _vehicle = _this select 0;

private _className = typeOf _vehicle;
private _class = (configFile >> "CfgVehicles" >> _className);

private _dragArray = [];
private _isAdvanced = toLower getText (_class >> "simulation") isEqualTo "planex";
if (_isAdvanced) then {
    _dragArray = [getArray (_class >> "airFrictionCoefs2"), getArray (_class >> "airFrictionCoefs1"), getArray (_class >> "airFrictionCoefs0")];
} else {
    _dragArray = [[0.00100, 0.00050, 0.00006], [0.100, 0.050, 0.006], [0, 0, 0]];
};

private _liftArray = getArray (_class >> "envelope");
private _speedMax = getNumber (_class >> "maxSpeed");
private _speedStall = getNumber (_class >> "stallSpeed");
private _angleOfIndicence = getNumber (_class >> "angleOfIndicence");
private _massStandard = getMass _vehicle;
if !(_massStandard > 0) then {
    _massStandard = 1000;
};

[_dragArray, _liftArray, [_speedMax, _speedStall, _angleOfIndicence, _massStandard]];
