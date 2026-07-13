class BCE_ATAK_Tool_ICON;

class ATAK_Buttons
{
	//- Buttons here
};

#include "page.hpp"
class ATAK_APPs
{
	class TaskViewer: BCE_ATAK_Tool_ICON
	{
		class Menu_Property
		{
			ORDER = 6;
			PAGE_CTRL = "";
		};

		text = ATAK_APP(Tasks);
		textureNoShortcut=QPATHTOEF(Core,data\check_box.paa);
	};
};