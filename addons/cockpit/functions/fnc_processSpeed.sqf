#include "script_component.hpp"

/*
Author: SynixeBrett
*/

params ["_kias"];

private _kph = _kias * EGVAR(main,knotToKph);

if (EGVAR(main,hasACEUnits)) exitWith {
	private _units = (vehicle ACE_player) call ace_units_fnc_speedUnits;
	private _speedInfo = _units call ace_units_fnc_speedInfo;
	((_kph / (_speedInfo select 1)) toFixed 0) + " " + (_speedInfo select 0)
};

private _output = switch (GVAR(checklistUnits)) do {
  case "KIAS": { (_kias toFixed 0) + " KIAS" };
  case "KM/H": { (_kph toFixed 0) + " KM/H" };
};

_output
