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