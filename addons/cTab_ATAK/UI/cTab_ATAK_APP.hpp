#include "ATAK_UI_Base.hpp"
// #include "ATAK_Buttons.hpp"

class ATAK_APPs
{
  //-Second Line
    class Route: BCE_ATAK_Tool_ICON
    {
      class Menu_Property
      {
        ORDER = 5;
        PAGE_CTRL = "";
      };

      text = ATAK_APP(Route);
			textureNoShortcut = QPATHTOEF(Core,data\route.paa);
    };
  
  //-Thired Line
    class Weather: BCE_ATAK_Tool_ICON
    {
      class Menu_Property
      {
        ORDER = 6;
        PAGE_CTRL = "";
      };

      text = ATAK_APP(Weather);
      textureNoShortcut="a3\3den\data\displays\display3den\toolbar\intel_ca.paa";
    };
    class BDA_Report: BCE_ATAK_Tool_ICON
    {
      class Menu_Property
      {
        ORDER = 7;
        PAGE_CTRL = "";
      };

      text = ATAK_APP(BDA Report);
      textureNoShortcut="a3\ui_f\data\igui\cfg\holdactions\holdaction_search_ca.paa";
    };
    
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