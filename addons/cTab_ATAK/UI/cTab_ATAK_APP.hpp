#include "ATAK_UI_Base.hpp"
// #include "ATAK_Buttons.hpp"

class ATAK_APPs
{
  //-Thired Line
    
    class settings: BCE_ATAK_Tool_ICON
    {
      class Menu_Property
      {
        ORDER = 8;
        PAGE_CTRL = "";
      };

      text = ATAK_APP(Settings);
			textureNoShortcut = QPATHTOEF(Core,data\settings.paa);
    };
};