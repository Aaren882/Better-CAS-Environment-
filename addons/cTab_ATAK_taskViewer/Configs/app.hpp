class BCE_ATAK_Tool_ICON;

class ATAK_Buttons
{
	//- Buttons here
};

#include "page.hpp"
#include "elements.hpp"
class ATAK_APPs
{
	class TaskViewer: BCE_ATAK_Tool_ICON
	{
		class Menu_Property
		{
			ORDER = 6;
			PAGE_CTRL = "ATAK_TaskViewer";
			Opened = QFUNC(ATAK_TaskViewer_Init);
			ATAK_Buttons = "Group_Menu";
		};

		text = ATAK_APP(Tasks);
		textureNoShortcut=QPATHTOEF(Core,data\check_box.paa);
	};
};