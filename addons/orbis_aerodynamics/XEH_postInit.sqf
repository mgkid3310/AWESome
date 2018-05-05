if (hasInterface) then {
	private _enabled = profileNamespace getVariable ["orbis_edition_aerodynamics_enabled", false];
	missionNamespace setVariable ["orbis_edition_aerodynamics_enabled", _enabled];

	[
		"orbis_edition_aerodynamics_enabled",
		"CHECKBOX",
		["Orbis Aerodynamics Toggle", "Can enable or disable Orbis Aerodynamics"],
		"Orbis Edition",
		[[true, false], ["Enabled, Disabled"], 1],
		nil,
		{
			missionNamespace setVariable ["orbis_edition_aerodynamics_enabled", _this];
			profileNamespace setVariable ["orbis_edition_aerodynamics_enabled", _this];

			private _hasEvent = missionNamespace getVariable ["orbis_edition_aerodynamics_hasEvent", false];
			if !(_hasEvent) then {
				player addEventHandler ["GetInMan", {_this spawn orbis_aerodynamics_fnc_eventGetInMan}];
				missionNamespace setVariable ["orbis_edition_aerodynamics_hasEvent", true];

				if (vehicle player in entities "Plane") then {
					[_vehicle, _unit] spawn orbis_aerodynamics_fnc_fixedWingInit;
				};
			};
		}
	] call CBA_Settings_fnc_init;

	if (_enabled) then {
    	player addEventHandler ["GetInMan", {_this spawn orbis_aerodynamics_fnc_eventGetInMan}];
		missionNamespace setVariable ["orbis_edition_aerodynamics_hasEvent", true];
	};
};
