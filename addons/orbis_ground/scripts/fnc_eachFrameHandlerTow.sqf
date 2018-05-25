private _car = missionNamespace getVariable ["orbis_towVehicle", objNull];
if (isNull _car) exitWith {};
if !(_car getVariable ["orbis_isTowingPlane", false]) exitWith {};

private _plane = _car getVariable ["orbis_towingTarget", objNull];
if (isNull _plane) exitWith {};

private _posCar = getPosASL _car;
private _posPlane = getPosASL _plane;
private _posCarOld = _car getVariable ["orbis_towingPosCarLast", getPosASL _car];
private _posPlaneOld = _car getVariable ["orbis_towingPosPlaneLast", getPosASL _plane];
private _distance = _car getVariable ["orbis_towingDistance", vectorMagnitude (_car worldToModel ASLToAGL getPosASL _plane)];
if (_posCar isEqualTo _posCarOld) exitWith {};

_plane attachTo [_car, vectorNormalized (_posPlaneOld vectorDiff _posCar) vectorMultiply _distance];
_plane setVectorDir ((getPosASL _plane) vectorFromTo (getPosASL _car));

_car setVariable ["orbis_towingPosCarLast", getPosASL _car];
_car setVariable ["orbis_towingPosPlaneLast", getPosASL _plane];
