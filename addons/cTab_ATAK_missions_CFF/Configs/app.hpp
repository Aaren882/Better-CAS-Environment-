class BCE_ATAK_Tool_ICON;

class ATAK_Buttons
{
	class MissionSend_Menu;
  class Task_CFF_Action_Menu: MissionSend_Menu
  {
    clickEvents[] = {
      QFUNC(ATAK_bnt_CFF_Action_Click),
      "cTab_Tablet_btnACT",
      QEFUNC(cTab_ATAK_missions,ATAK_ShowTaskResult)
    };
  };
  class Task_CFF_List_Menu: MissionSend_Menu
  {
    onLoad = QFUNC(ATAK_bnt_CFF_List); //- [ALL the Buttons]
    clickEvents[] = {
      QEFUNC(cTab_ATAK_missions,ATAK_ShowTaskResult) //- Refresh CFF List
    };
  };
};

#include "page.hpp"
#include "elements.hpp"
class ATAK_APPs
{
	class mission: BCE_ATAK_Tool_ICON
	{
		class Menu_Property
		{
			class Pages
			{
				class Task_CFF_List
				{
					PAGE_CTRL = "Task_CFF_List";
					Opened = QFUNC(ATAK_mission_SUB_TaskCFFList);
					ATAK_Buttons = "Task_CFF_List_Menu";
				};
				class Task_CFF_Action
				{
					PAGE_CTRL = "Task_CFF_Action";
					Opened = QFUNC(ATAK_mission_SUB_TaskCFF_Action);
					LastPage = "Task_CFF_List"; //- ClassName of the page
					ATAK_Buttons = "Task_CFF_Action_Menu";
				};
			};
		};
	};
};