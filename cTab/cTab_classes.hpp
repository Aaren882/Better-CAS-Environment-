/*
  #NOTE - This will be included in "RscTitles" + "Dialog"
*/

//- TAD
  class cTab_TAD_OSD_navModeOrScale;
  class cTab_TAD_OSD_txtToggleIconBg;
  class cTab_TAD_OSD_txtToggleIcon;
  class cTab_TAD_RscMapControl_BLACK;

//-Clean up
#if MAP_MODE > 0
	//-Change TOPO -> Enhanced GPS
	class cTab_Tablet_RscMapControl: RscMapControl{};
	class cTab_microDAGR_RscMapControl: RscMapControl{};
	class cTab_TAD_RscMapControl: RscMapControl{};
#else
	class cTab_Tablet_RscMapControl: cTab_RscMapControl{};
	class cTab_microDAGR_RscMapControl: cTab_RscMapControl{};
	class cTab_TAD_RscMapControl: cTab_RscMapControl{};
#endif

//- Phone
  #include "cTab_Android_Widgets.hpp"
  #include "cTab_Android_Layout.hpp"