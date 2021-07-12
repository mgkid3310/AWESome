#define MAINPREFIX z
#define PREFIX orbis

#include "script_version.hpp"

#define VERSION MAJOR.MINOR.PATCH.BUILD
#define VERSION_AR MAJOR,MINOR,PATCH,BUILD

#define AWESOME_TAG AWESOME

// MINIMAL required version for the Mod. Components can specify others..
#define REQUIRED_VERSION 2.00

#ifdef COMPONENT_BEAUTIFIED
	#define COMPONENT_NAME QUOTE(AWESome - COMPONENT_BEAUTIFIED)
#else
	#define COMPONENT_NAME QUOTE(AWESome - COMPONENT)
#endif
