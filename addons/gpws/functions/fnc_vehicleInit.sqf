#include "script_component.hpp"

params ["_vehicle"];

private _firedEventHandlerID = _vehicle getVariable [QGVAR(firedEventHandlerID), false];
if !(_firedEventHandlerID isEqualType 0) then {
	_firedEventHandlerID = _vehicle addEventHandler ["Fired", {_this spawn FUNC(f16ChaffFlare)}];
	_vehicle setVariable [QGVAR(firedEventHandlerID), _firedEventHandlerID];
};

private _incomingMSLEventHandlerID = _vehicle getVariable [QGVAR(incomingMSLEventHandlerID), false];
if !(_incomingMSLEventHandlerID isEqualType 0) then {
	_incomingMSLEventHandlerID = _vehicle addEventHandler ["IncomingMissile", {_this spawn FUNC(incomingMSL)}];
	_vehicle setVariable [QGVAR(incomingMSLEventHandlerID), _incomingMSLEventHandlerID];
};
