#include "..\script_component.hpp"

#define ATIS_SLEEP(var_t) if !(_noSound || (_vehicle getVariable [QGVAR(stopATIS), false])) then {sleep var_t};
