private _player = player;
private _planes = nearestObjects [player, ["globemaster_c17"], 100];

if (count _planes isEqualTo 0) exitWith {};

private _carrier = _planes select 0;
private _oldArray = _carrier getVariable ["orbis_paradrop_attachArray", [-1, [0, 0, 0], [0, 0, 0]]];
private _arrayNil = _oldArray select 0 < 0;
private _velOld = _oldArray select 1;
private _posOld = _oldArray select 2;
private _relOld = _oldArray select 3;
private _velNow = velocity _carrier;
private _posNow = getPosASL _carrier;

_carrier vectorModelToWorld _relOld;

private _posRel = [_carrier, _player] call orbis_paradrop_fnc_getPosRel;
private _doAttach = (abs (_posRel select 0) < 2.5) && (_posRel select 1 < 16) && (_posRel select 1 > -14.5) && (_posRel select 2 < 1) && (_posRel select 2 > -1.3);

if (!_arrayNil && _doAttach) then {
	// _player setVelocity (velocity _player vectorAdd _velNow vectorDiff _velOld);
	private _newPos = getPosASL _player vectorAdd _posNow vectorDiff _posOld;
	_newPos = _newPos vectorAdd (_carrier vectorModelToWorld _posRel) vectorDiff (_carrier vectorModelToWorld _relOld);
	_player setPosASL _newPos;
};
