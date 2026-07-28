class BCE_ATAK_Tool_ICON;

class ATAK_Buttons
{
	//- Buttons here
};

#include "page.hpp"
class ATAK_APPs
{
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