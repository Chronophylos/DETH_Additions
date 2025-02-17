/**
Fast Recompiling via function
**/
#define DISABLE_COMPILE_CACHE
// To Use: [] call DTA_PREP_RECOMPILE;

#ifdef DISABLE_COMPILE_CACHE
    #define LINKFUNC(x) {call FUNC(x)}
    #define PREP_RECOMPILE_START    if (isNil "DTA_PREP_RECOMPILE") then {DTA_recompiles = []; DTA_PREP_RECOMPILE = {{call _x} forEach DTA_recompiles;}}; private _recomp = {
    #define PREP_RECOMPILE_END      }; call _recomp; DTA_recompiles pushBack _recomp;
#else
    #define LINKFUNC(x) FUNC(x)
    #define PREP_RECOMPILE_START ; /* disabled */
    #define PREP_RECOMPILE_END ; /* disabled */
#endif
