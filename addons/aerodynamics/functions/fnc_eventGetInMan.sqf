#include "script_component.hpp"

private _vehicle = _this select 2;

_vehicle addEventHandler ["LandedTouchDown", {_this call FUNC(eventTouchdown)}];
