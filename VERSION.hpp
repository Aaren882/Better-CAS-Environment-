#define MAJOR 1
#define MINOR 0
#define PATCHLVL 0
#define BUILD 0

#define VERSION_NUM MAJOR.MINOR
#define VERSION_STR MAJOR,MINOR,PATCHLVL,BUILD
#define VERSION_AR MAJOR,MINOR,PATCHLVL,BUILD


#ifndef VERSION_CONFIG
    #define VERSION_CONFIG \
        version = VERSION_NUM; \
        versionStr = #VERSION_STR; \
        versionAr[] = {VERSION_AR}
#endif