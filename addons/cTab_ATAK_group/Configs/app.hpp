class BCE_ATAK_Tool_ICON;

class ATAK_Buttons
{
	class Group_Menu
  {
    onLoad = QFUNC(ATAK_bnt_Group); //- [ALL the Buttons]
    clickEvents[] = {
      ""
    };
  };
};

#include "page.hpp"
#include "elements.hpp"
class ATAK_APPs
{
	class Group: BCE_ATAK_Tool_ICON
	{
		class Menu_Property
		{
			ORDER = 4;
			PAGE_CTRL = "";
			// PAGE_CTRL = "ATAK_Group";
			// Opened = QFUNC(ATAK_Group_Init);
			// ATAK_Buttons = "Group_Menu";
		};

		text = ATAK_APP(Groups);
		textureNoShortcut="a3\3den\data\displays\display3den\panelright\modegroups_ca.paa";
	};
};