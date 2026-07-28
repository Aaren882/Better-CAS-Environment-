class BCE_ATAK_Tool_ICON;

class ATAK_Buttons
{
	//- Buttons here
};

#include "page.hpp"
class ATAK_APPs
{
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
};