private _timeOld = missionNamespace getVariable ["orbis_atc_timeOld", -1];
private _frameOld = missionNamespace getVariable ["orbis_atc_frameOld", -1];

if (!(alive player) || (_timeOld < 0) || (_frameOld < 0)) exitWith {
	missionNamespace setVariable ["orbis_atc_timeOld", time];
	missionNamespace setVariable ["orbis_atc_frameOld", diag_frameNo];
};

private _isUsingRadarScreen = player getVariable ["orbis_atc_isUsingRadarScreen", false];
private _startRadarScreen = player getVariable ["orbis_atc_startRadarScreen", false];
private _radarScreenParam = player getVariable ["orbis_atc_radarScreenParam", []];

if (_startRadarScreen isEqualType []) then {
	_isUsingRadarScreen = true;
	_radarScreenParam = _startRadarScreen;
	player setVariable ["orbis_atc_isUsingRadarScreen", true, true];
	player setVariable ["orbis_atc_startRadarScreen", false, true];
	player setVariable ["orbis_atc_radarScreenParam", _radarScreenParam, true];
};

if (_isUsingRadarScreen) then {
	_radarScreenParam call orbis_atc_fnc_atcRadarLoop;
};

missionNamespace setVariable ["orbis_gpws_timeOld", time];
missionNamespace setVariable ["orbis_gpws_frameOld", diag_frameNo];
