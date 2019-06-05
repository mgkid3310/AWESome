#define MAINPREFIX z
#define PREFIX awesome

#include "script_version.hpp"

#define VERSION MAJOR.MINOR.PATCHLVL.BUILD
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD

#define AWESOME_TAG AWESOME

// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 1.84

#ifdef COMPONENT_BEAUTIFIED
    #define COMPONENT_NAME QUOTE(AWESome - COMPONENT_BEAUTIFIED)
#else
    #define COMPONENT_NAME QUOTE(AWESome - COMPONENT)
#endif
