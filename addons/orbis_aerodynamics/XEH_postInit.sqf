// init global variable
orbis_aerodynamics_loopFrameInterval = 5;

// add EventHandlers
addMissionEventHandler ["EachFrame", {[] call orbis_aerodynamics_fnc_eachFrameHandler}];

// CBA based addon setting init
if (hasInterface) then {
	private _enabled = profileNamespace getVariable ["orbis_aerodynamics_enabled", false];
	missionNamespace setVariable ["orbis_aerodynamics_enabled", _enabled];

	[
		"orbis_aerodynamics_enabled",
		"LIST",
		["Advanced Aerodynamics", "Can enable or disable Advanced Aerodynamics"],
		"AWESome",
		[[true, false], ["Enabled", "Disabled"], 1],
		nil,
		{
			missionNamespace setVariable ["orbis_aerodynamics_enabled", _this];
			profileNamespace setVariable ["orbis_aerodynamics_enabled", _this];
		}
	] call CBA_Settings_fnc_init;
};
