private _vehicle = _this select 0;

private _className = typeOf _vehicle;
private _class = (configFile >> "CfgVehicles" >> _className);

private _dragArray = [];
private _isAdvanced = toLower getText (_class > "simulation") isEqualTo "planex";
if (_isAdvanced) then {
    _dragArray = [getArray (_class > "airFrictionCoefs2"), getArray (_class > "airFrictionCoefs1"), getArray (_class > "airFrictionCoefs0")];
} else {
    _dragArray = [getArray (_class > "airFriction"), [0, 0, 0], [0, 0, 0]];
};

[_dragArray];
