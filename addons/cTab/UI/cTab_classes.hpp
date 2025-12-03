/*
  #NOTE - This will be included in "RscTitles" + "Dialog"
*/

//- TAD
  class cTab_TAD_OSD_navModeOrScale;
  class cTab_TAD_OSD_txtToggleIconBg;
  class cTab_TAD_OSD_txtToggleIcon;
  class cTab_TAD_RscMapControl_BLACK;

//- Phone
  #include "cTab_Android_Layout.hpp"

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