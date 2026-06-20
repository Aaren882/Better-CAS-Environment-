/*
  #NOTE - This will be included in "RscTitles" + "Dialog"
*/

//- Base definitions
#include "..\..\cTab\UI\cTab_UI_Base.hpp"
#include "..\..\cTab\UI_Components.hpp"

#ifdef IS_DIALOG
	//- Tablet
		#include "Layouts\cTab_Tablet_Layout.hpp"
	//- 
#endif

//- Phone
  #include "Layouts\cTab_Android_Layout.hpp"

/* 
  #SECTION - [MAP_MODE] is used to determine the map control type.
  - 0: Default
  - 1: Map DarkMode
  - 2: Enhanced Map
  - 3: Enhanced GPS
*/
  #if MAP_MODE > 0
    //-Change TOPO -> Enhanced GPS
    class cTab_Tablet_RscMapControl: RscMapControl{};
    class cTab_microDAGR_RscMapControl: RscMapControl{};
    class cTab_TAD_RscMapControl: RscMapControl{};
    class cTab_android_RscMapControl: cTab_RscMapControl
    {
      x = QUOTE((((452))) / 2048  * 	PhoneW + 	CustomPhoneX);
      y = QUOTE((((713) + (60))) / 2048  * 	CustomPhoneH + 	CustomPhoneY);
      w = QUOTE((((PHONE_MOD))) / 2048  * 	PhoneW);
      h = QUOTE((((626) - (60) - (0))) / 2048  * 	CustomPhoneH);
    };
  #else
    class cTab_Tablet_RscMapControl: cTab_RscMapControl{};
    class cTab_microDAGR_RscMapControl: cTab_RscMapControl{};
    class cTab_TAD_RscMapControl: cTab_RscMapControl{};
    class cTab_android_RscMapControl: cTab_RscMapControl
    {
      x = QUOTE((((452))) / 2048  * 	PhoneW + 	CustomPhoneX);
      y = QUOTE((((713) + (60))) / 2048  * 	CustomPhoneH + 	CustomPhoneY);
      w = QUOTE((((PHONE_MOD))) / 2048  * 	PhoneW);
      h = QUOTE((((626) - (60) - (0))) / 2048  * 	CustomPhoneH);
    };
  #endif

	