private _car = _this select 0;

if (!(_car getVariable ["awesome_hasTowBarDeployed", false]) || (_car getVariable ["awesome_isTowingPlane", false])) exitWith {false};

private _towArray = [_car] call awesome_ground_fnc_getTowTarget;

!(isNull (_towArray select 0))
