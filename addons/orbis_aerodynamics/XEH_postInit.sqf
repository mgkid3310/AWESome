if (hasInterface) then {
	private _enabled = profileNamespace getVariable ["orbis_edition_aerodynamics_enabled", false];
	missionNamespace setVariable ["orbis_edition_aerodynamics_enabled", _enabled];

	[
		"orbis_edition_aerodynamics_enabled",
		"LIST",
		["Orbis Aerodynamics Toggle", "Can enable or disable Orbis Aerodynamics"],
		"Orbis Edition",
		[[true, false], ["Enabled", "Disabled"], 1],
		nil,
		{
			missionNamespace setVariable ["orbis_edition_aerodynamics_enabled", _this];
			profileNamespace setVariable ["orbis_edition_aerodynamics_enabled", _this];

			if (_this && (vehicle player in entities "Plane")) then {
				[vehicle player, player] spawn orbis_aerodynamics_fnc_fixedWingInit;
			};
		}
	] call CBA_Settings_fnc_init;
};

player addEventHandler ["GetInMan", {_this spawn orbis_aerodynamics_fnc_eventGetInMan}];
