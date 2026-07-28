class BCE_ATAK_Tool_ICON;

class ATAK_Buttons
{
	class VideoFeeds_Menu
  {
    onLoad = QFUNC(ATAK_bnt_VideoFeeds); //- [ALL the Buttons]
    clickEvents[] = {
			QFUNC(ATAK_bnt_VideoFeeds_Click)
    };
  };
};

#include "page.hpp"
class ATAK_APPs
{
	class VideoFeeds: BCE_ATAK_Tool_ICON
	{
		class Menu_Property
		{
			ORDER = 2;
			PAGE_CTRL = "ATAK_Video";
			Opened = QFUNC(ATAK_VideoFeeds_Init);
			ATAK_Buttons = "VideoFeeds_Menu";
		};

		text = ATAK_APP(Video Feeds);
		textureNoShortcut = QPATHTOEF(Core,data\Hcam.paa);
	};
};