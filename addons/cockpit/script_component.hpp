#define COMPONENT cockpit
#include "\z\awesome\addons\cockpit\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS
// #define ENABLE_PERFORMANCE_COUNTERS

#ifdef DEBUG_ENABLED_COCKPIT
  #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_COCKPIT
  #define DEBUG_SETTINGS DEBUG_SETTINGS_COCKPIT
#endif

#include "\z\awesome\addons\main\script_macros.hpp"