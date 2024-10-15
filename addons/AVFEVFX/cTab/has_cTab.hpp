//-Check cTab
#pragma hemtt flag pe23_ignore_has_include

#if __has_include("\cTab\config.bin")
	#define cTAB_Installed 1
#endif

#if __has_include("\cTab\config.cpp")
	#define cTAB_Installed 1
#endif