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

private _liftArray = getArray (_class >> "maxSpeed");
private _speedMax = getNumber (_class >> "landingSpeed");
private _speedStall = getNumber (_class >> "stallSpeed");

[_dragArray, _liftArray, [_speedMax, _speedStall]];
