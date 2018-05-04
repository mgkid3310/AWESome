private _monitor = _this select 0;
private _controller = param [1, player];

player setVariable ["isUsingRadarScreen", true, true];

private _timeNext = 0;
private _planes = [];
private _helies = [];
private _planeMarkers = [];
private _heliMarkers = [];

while {((player distance _monitor) < 10) && (player getVariable ["isUsingRadarScreen", true])} do {
    // update planes info
    if (time > _timeNext) then {
        _planes = (entities "Plane") select {(side driver _x in [side _controller, civilian]) && (alive _x)};
        _helies = (entities "Helicopter") select {(side driver _x in [side _controller, civilian]) && (alive _x)};

        {
            _x params ["_marker1", "_marker2", "_marker3"];
            deleteMarkerLocal _marker1;
            deleteMarkerLocal _marker2;
            deleteMarkerLocal _marker3;
        } forEach (_planeMarkers + _heliMarkers);

        _planeMarkers = [_planes, "b_plane"] call orbis_atc_fnc_createMarkers;
        _heliMarkers = [_helies, "b_air"] call orbis_atc_fnc_createMarkers;
        [_planeMarkers, _heliMarkers] call orbis_atc_fnc_updateMarkerSpacing;
        missionNamespace setVariable ["oribs_atc_planeMarkers", _planeMarkers];
        missionNamespace setVariable ["oribs_atc_heliMarkers", _heliMarkers];

        _timeNext = time + 1;
    };

    // update marker line spacing
    [_planeMarkers + _heliMarkers] call orbis_atc_fnc_updateMarkerSpacing;

    private _frameNo = diag_frameNo;
	waitUntil {diag_frameNo > _frameNo};
};

// delete remaining markers
{
    _x params ["_marker1", "_marker2", "_marker3"];
    deleteMarkerLocal _marker1;
    deleteMarkerLocal _marker2;
    deleteMarkerLocal _marker3;
} forEach (_planeMarkers + _heliMarkers);

if !((player distance _monitor) < 10) then {
    [parseText format["<t align='center'>Became too far from the Radar Screen</t>"], [0.25, 1, 0.5, 0.05], [1, 1], 2] spawn BIS_fnc_textTiles;
};
player setVariable ["isUsingRadarScreen", false, true];
