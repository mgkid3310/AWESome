// init global variable
orbis_aerodynamics_loopFrameInterval = 4;

// add EventHandlers
addMissionEventHandler ["EachFrame", {[] call orbis_aerodynamics_fnc_eachFrameHandler}];

// CBA based addon setting init
if (hasInterface) then {
	private _enabled = profileNamespace getVariable ["orbis_aerodynamics_enabled", true];
	missionNamespace setVariable ["orbis_aerodynamics_enabled", _enabled];

	[
		"orbis_aerodynamics_enabled",
		"LIST",
		["Advanced Aerodynamics", "Can enable or disable Advanced Aerodynamics"],
		"AWESome",
		[[false, true], ["Disabled", "Enabled"], [0, 1] select _enabled],
		nil,
		{
			missionNamespace setVariable ["orbis_aerodynamics_enabled", _this];
			profileNamespace setVariable ["orbis_aerodynamics_enabled", _this];
		}
	] call CBA_Settings_fnc_init;
};
