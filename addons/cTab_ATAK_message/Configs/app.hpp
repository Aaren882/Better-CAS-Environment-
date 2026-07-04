class BCE_ATAK_Tool_ICON;

class ATAK_Buttons
{
	class Message_Menu
  {
    onLoad = QFUNC(ATAK_bnt_Message); //- [ALL the Buttons]
    clickEvents[] = {
			QFUNC(ATAK_bnt_MessageSend_Click)
    };
  };
};

#include "page.hpp"
#include "elements.hpp"
class ATAK_APPs
{
	class message: BCE_ATAK_Tool_ICON
	{
		class Menu_Property
		{
			ORDER = 0; //- Default Order (Customizable)
			PAGE_CTRL = "ATAK_Message"; //- which "Control Class" switch to
			Opened = QFUNC(ATAK_message_Init);
			ATAK_Buttons = "Message_Menu";
		};
		
		text = ATAK_APP(Message);
		textureNoShortcut=QPATHTOEF(Core,data\mail.paa);
	};
};