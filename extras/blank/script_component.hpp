#define COMPONENT <name>
#define COMPONENT_BEAUTIFIED <Name>
#include "\z\dta\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE
// #define CBA_DEBUG_SYNCHRONOUS

#ifdef DEBUG_ENABLED_<NAME>
    #define DEBUG_MODE_FULL
#endif

#ifdef DEBUG_SETTINGS_<NAME>
    #define DEBUG_SETTINGS DEBUG_SETTINGS_<NAME>
#endif

#include "\z\dta\addons\main\script_macros.hpp"
