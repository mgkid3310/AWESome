#include "script_component.hpp"

params ["_altitude", "_temperature", "_pressure", "_humidity"];

// Arden Buck equation
_humidity = _humidity * linearConversion [11000, 12000, _altitude, 1, 0];
private _partialPressureWater = _humidity * 6.1121 * exp ((18.678 - (_temperature / 234.5)) * (_temperature / (257.14 + _temperature))); // hPa
private _partialPressureDry = _pressure - _partialPressureWater; // hPa
private _density = 100 * ((_partialPressureDry * 0.028964) + (_partialPressureWater * 0.018016)) / (8.314 * (_temperature + 273.15)); // kg/m^3

_density max 0
