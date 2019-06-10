#include "\x\cba\addons\main\script_macros_common.hpp"

#define DFUNC(var1) TRIPLES(ADDON,fnc,var1)

#ifdef DISABLE_COMPILE_CACHE
  #undef PREP
  #define PREP(fncName) DFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
#else
  #undef PREP
  #define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#endif

/* #define GETQQVAR_SYS(var1,var2) getVariable [ARR_2(QUOTE(QUOTE(var1)),var2)]
#define SETQQVAR_SYS(var1,var2) setVariable [ARR_2(QUOTE(QUOTE(var1)),var2)]
#define SETPQQVAR_SYS(var1,var2) setVariable [ARR_3(QUOTE(QUOTE(var1)),var2,true)]

#define GETQQVAR(var1,var2,var3) (var1 GETQQVAR_SYS(var2,var3))
#define SETQQVAR(var1,var2,var3) (var1 SETQQVAR_SYS(var2,var3))
#define SETPQQVAR(var1,var2,var3) (var1 SETPQQVAR_SYS(var2,var3)) */
