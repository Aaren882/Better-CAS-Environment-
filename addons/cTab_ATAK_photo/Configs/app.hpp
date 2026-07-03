class BCE_ATAK_Tool_ICON;

class ATAK_APPs
{
	class Photo: BCE_ATAK_Tool_ICON
	{
		class Menu_Property
		{
			ORDER = 3;
			PAGE_CTRL = "";
		};

		onButtonClick = "558 cutRsc ['BCE_PhoneCAM_View','PLAIN',0.3,false];";
		
		text = ATAK_APP(Quick Pictures);
		textureNoShortcut = QPATHTOEF(Core,data\photo.paa);
	};
};