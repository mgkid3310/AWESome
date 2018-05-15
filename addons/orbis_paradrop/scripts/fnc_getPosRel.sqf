params ["_coordinate", "_object"];

private _posRel = _coordinate worldToModelVisual [getPosATL _object select 0, getPosATL _object select 1, (getPosATL _object select 2) - ((_object worldToModelVisual (getPosATL _object)) select 2)];

_posRel
