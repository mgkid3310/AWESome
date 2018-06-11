private _player = param [0, player];
private _vehicle = param [1, vehicle player];

if (_player isEqualTo _vehicle) exitWith {};

private _role = assignedVehicleRole _player;
private _return = false;
switch (toLower (_role select 0)) do {
    case ("driver"): {
        _return = true;
    };
    case ("turret"): {
        if ((_role select 1) isEqualTo [0]) then {
            _return = true;
        };
    };
};

_return
