#include "\x\cba\addons\main\script_macros_common.hpp"

#define DFUNC(var1) TRIPLES(ADDON,fnc,var1)
#define DFUNCMAIN(var1) TRIPLES(PREFIX,fnc,var1)

#define STRUCTURE_IMAGE(var1,var2) <img image='PATHTOEF(var1,var2)' />
#define STRUCTURE_IMAGE_MODIFY(var1,var2,var3) <img var3 image='PATHTOEF(var1,var2)' />

#define QSTRUCTURE_IMAGE(var1,var2) QUOTE(STRUCTURE_IMAGE(var1,var2))
#define QSTRUCTURE_IMAGE_MODIFY(var1,var2,var3) QUOTE(STRUCTURE_IMAGE_MODIFY(var1,var2,var3))

// # EXAMPLE
//- "<img image='z\BCE\{var1}\{var2}'/>{ var3}"
//- "<img image='z\BCE\{Core}\{data\archive.paa}'/>{ RAT}"
#define STRUCTURE_IMAGE_FORMAT(var1,var2,var3) STRUCTURE_IMAGE(var1,var2)##var3
#define QSTRUCTURE_IMAGE_FORMAT(var1,var2,var3) QUOTE(STRUCTURE_IMAGE_FORMAT(var1,var2,var3))

//- Custom Macro
#include "macro.hpp"
#include "has_cTab.hpp"

/* #ifdef DISABLE_COMPILE_CACHE
    #undef PREP
    #define PREP(fncName) DFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
    #undef PREPMAIN
    #define PREPMAIN(fncName) DFUNCMAIN(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
#else
    #undef PREP
    #define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
    #undef PREPMAIN
    #define PREPMAIN(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNCMAIN(fncName)] call CBA_fnc_compileFunction
#endif */
