/* 
	#NOTE - These are dialogs
*/

#define MOUSE_CLICK_EH "(_this + [17000]) call BCE_fnc_GetMapClickPOS"

//- Dialogs
	#include "Devices\cTab_Tablet.hpp"
	#include "Devices\cTab_FBCB2.hpp"
	#include "Devices\cTab_TAD.hpp"
  #include "Devices\cTab_Android.hpp"

//- Displays
class RscTitles
{
	#undef IS_DIALOG
	#undef MOUSE_CLICK_EH
	#include "cTab_Macros_Interface.hpp"
	
	//- display
	#include "Devices\cTab_TAD.hpp"
	#include "Devices\cTab_Android.hpp"
};