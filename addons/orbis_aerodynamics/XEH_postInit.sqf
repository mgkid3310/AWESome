// init global variable
orbis_aerodynamics_loopFrameInterval = 4;

// add EventHandlers
player addEventHandler ["GetInMan", {_this call orbis_aerodynamics_fnc_eventGetInMan}];
addMissionEventHandler ["EachFrame", {[] call orbis_aerodynamics_fnc_eachFrameHandler}];

if !(vehicle player isEqualTo player) then {
	[nil, nil, vehicle player] call orbis_aerodynamics_fnc_eventGetInMan;
};

// CBA based addon setting init
if (hasInterface) then {
	private _enabled = profileNamespace getVariable ["orbis_aerodynamics_enabled", true];
	private _windMultiplier = profileNamespace getVariable ["orbis_aerodynamics_windMultiplier", 1];
	missionNamespace setVariable ["orbis_aerodynamics_enabled", _enabled];
	missionNamespace setVariable ["orbis_aerodynamics_windMultiplier", _windMultiplier];

	[
		"orbis_aerodynamics_enabled",
		"LIST",
		["Advanced Aerodynamics", "Can enable or disable Advanced Aerodynamics"],
		"AWESome",
		[[true, false], ["Enabled", "Disabled"], [1, 0] select _enabled],
		nil,
		{
			missionNamespace setVariable ["orbis_aerodynamics_enabled", _this];
			profileNamespace setVariable ["orbis_aerodynamics_enabled", _this];
		}
	] call CBA_Settings_fnc_init;

	[
		"orbis_aerodynamics_windMultiplier",
		"SLIDER",
		["Wind Multiplier", "Sets shadow view distance"],
		"AWESome",
		[0, 1, _windMultiplier, 2],
		nil,
		{
			missionNamespace setVariable ["orbis_aerodynamics_windMultiplier", _this];
			profileNamespace setVariable ["orbis_aerodynamics_windMultiplier", _this];
		}
	] call CBA_Settings_fnc_init;
};
