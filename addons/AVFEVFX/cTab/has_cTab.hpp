#pragma hemtt flag pe23_ignore_has_include
#include "\a3\editor_f\Data\Scripts\dikCodes.h"

//-Check cTab
#if __has_include("\cTab\config.bin")
	#define cTAB_Installed 1
#endif

#if __has_include("\cTab\config.cpp")
	#define cTAB_Installed 1
#endif