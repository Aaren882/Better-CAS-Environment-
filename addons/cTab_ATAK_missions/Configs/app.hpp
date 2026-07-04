class BCE_ATAK_Tool_ICON;

class ATAK_Buttons
{
	class MissionSend_Menu
  {
    onLoad = QFUNC(ATAK_bnt_SendMission); //- [ALL the Buttons]
    clickEvents[] = {
      QFUNC(ATAK_DataReceiveButton),
      "cTab_Tablet_btnACT",
      QFUNC(ATAK_ShowTaskResult)
    };
  };
  class Task_CFF_Action_Menu: MissionSend_Menu
  {
    clickEvents[] = {
      "BCE_fnc_ATAK_bnt_CFF_Action_Click",
      "cTab_Tablet_btnACT",
      QFUNC(ATAK_ShowTaskResult)
    };
  };
  class Task_CFF_List_Menu: MissionSend_Menu
  {
    onLoad = "BCE_fnc_ATAK_bnt_CFF_List"; //- [ALL the Buttons]
    clickEvents[] = {
      QFUNC(ATAK_ShowTaskResult) //- Refresh CFF List
    };
  };
  class TaskBuilding_Menu
  {
    onLoad = QFUNC(ATAK_bnt_TaskBuilding); //- [ALL the Buttons]
    clickEvents[] = {
      QFUNC(ATAK_DataReceiveButton),
      "cTab_Tablet_btnACT",
      QFUNC(ATAK_ShowTaskResult)
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
			ORDER = 1;
			PAGE_CTRL = "Task_Builder";
			Opened = QFUNC(ATAK_mission_Init);
			ATAK_Buttons = "MissionSend_Menu";
			class Pages
			{
				class Task_Building
				{
					PAGE_CTRL = "Task_Building";
					Opened = QFUNC(ATAK_mission_SUB_TaskBuilding);
					ATAK_Buttons = "TaskBuilding_Menu";
				};
				class Task_CFF_List
				{
					PAGE_CTRL = "Task_CFF_List";
					Opened = "BCE_fnc_ATAK_mission_SUB_TaskCFFList";
					ATAK_Buttons = "Task_CFF_List_Menu";
				};
				class Task_CFF_Action
				{
					PAGE_CTRL = "Task_CFF_Action";
					Opened = "BCE_fnc_ATAK_mission_SUB_TaskCFF_Action";
					LastPage = "Task_CFF_List"; //- ClassName of the page
					ATAK_Buttons = "Task_CFF_Action_Menu";
				};
				class Task_Result
				{
					PAGE_CTRL = "Task_Result";
					Opened = QFUNC(ATAK_mission_SUB_TaskResult);
					// ATAK_Buttons = "TaskBuilding_Menu";
				};
			};
		};

		text = ATAK_APP(Missions);
		textureNoShortcut = QPATHTOEF(Core,data\missions.paa);
	};
};