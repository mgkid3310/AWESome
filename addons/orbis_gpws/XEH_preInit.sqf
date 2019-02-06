#include "XEH_PREP.sqf"

// add addon settings
private _defaultMode = profileNamespace getVariable ["orbis_gpws_personallDefault", "none"];
missionNamespace setVariable ["orbis_gpws_personallDefault", _defaultMode];
[
	"orbis_gpws_personallDefault",
	"LIST",
	["Default GPWS Mode", "Activates default GPWS when boarding planes with GPWS turned off"],
	"AWESome GPWS",
	[["none", "b747", "f16", "rita"], ["No default setting", "B747", "Betty (F-16)", "Rita"], ["none", "b747", "f16", "rita"] find _defaultMode],
	nil,
	{
		missionNamespace setVariable ["orbis_gpws_personallDefault", _this];
		profileNamespace setVariable ["orbis_gpws_personallDefault", _this];
        saveProfileNamespace;
	}
] call CBA_Settings_fnc_init;

private _defaultVolumeLow = profileNamespace getVariable ["orbis_gpws_defaultVolumeLow", false];
missionNamespace setVariable ["orbis_gpws_defaultVolumeLow", _defaultVolumeLow];
[
	"orbis_gpws_defaultVolumeLow",
	"LIST",
	["Default GPWS Volume", "Sets default GPWS volume (high/low)"],
	"AWESome GPWS",
	[[false, true], ["High", "Low"], [0, 1] select _defaultVolumeLow],
	nil,
	{
		missionNamespace setVariable ["orbis_gpws_defaultVolumeLow", _this];
		profileNamespace setVariable ["orbis_gpws_defaultVolumeLow", _this];
        saveProfileNamespace;
	}
] call CBA_Settings_fnc_init;
