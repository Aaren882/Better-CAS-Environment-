class CfgFunctions
{
	class BCE
	{
		class ATAK
    {
      file=QPATHTOF(functions);
      class ATAK_LastPage;
      class ATAK_bnt_clickEvent;
      class ATAK_getScrollValue;
      class ATAK_Check_Layout;
      class ATAK_Camera_Controls;
    };
    //- ATAK Menus
      class ATAK_Fire_Mission
      {
        file=QPATHTOF(functions\Fire_Mission);
        class ATAK_DescType_Changed;
        class ATAK_set_TaskType;
        class ATAK_TaskTypeChanged;
        class ATAK_LBTaskUnitChanged;
        class ATAK_AutoSaveTask;
        class ATAK_Refresh_TaskInfos;
        class ATAK_Refresh_Weapons;
        class ATAK_PullData;
        class ATAK_ShowTaskResult;
        class ATAK_onVehicleChanged;
        class ATAK_updateTaskControl;
        class ATAK_getTaskCategoryInfo;
        class ATAK_TaskUnitChanged_AIR;
      };
      class ATAK_Call_for_Fire_Menu
      {
        file=QPATHTOF(functions\Fire_Mission\Call_for_Fire);
        class ATAK_CFF_TaskList_Init;
        class ATAK_CFF_Mission_RAT;				//- Record as Target
        class ATAK_CFF_Mission_RAT_2_ADD;	//- Add the Mission
        class ATAK_CFF_Mission_EOM;				//- End of Mission
      };
      class ATAK_CFF_Adjust_Menu
      {
        file=QPATHTOF(functions\Fire_Mission\Call_for_Fire\Fire_Adjustments);
        class ATAK_FireAdjust_Init_Polar;
        class ATAK_FireAdjust_Init_Impact;
        class ATAK_FireAdjust_Sel_Changed;

        class ATAK_onFireAdjusted;
        class ATAK_FireAdjustMeter;
      };
      class ATAK_Menu_Init
      {
        file=QPATHTOF(functions\Menu\Init);
        class ATAK_setAPPs_props;
        class ATAK_getAPPs_props;
      };
      class ATAK_Menu_Custom_Controls
      {
        file=QPATHTOF(functions\Menu\Custom_Controls);
        class ATAK_Custom_DropMenu_Init;
        class ATAK_Custom_DropMenu_Click;

        class Create_ATAK_Custom_DropMenu; //- Create Custom DropMenu
        class Clear_ATAK_Custom_DropMenu; //- Clear Custom DropMenu
        class Init_ATAK_Custom_DropMenu; //- Initiate Custom DropMenu
      };
      class ATAK_Menu
      {
        file=QPATHTOF(functions\Menu);
        class ATAK_getAPPs;
        class ATAK_openPage;
        class ATAK_openMenu;
        class ATAK_ChangeTool;
        class ATAK_createSubPage;
        class ATAK_getAPP_Config;
        class ATAK_toggleSubListMenu;
        class ATAK_getCurrentAPP;
        class ATAK_getLastAPP;
        class ATAK_ignoreFade_Transform;
      };
      class ATAK_Menu_Buttons
      {
        file=QPATHTOF(functions\Menu\Button_Events);
        class ATAK_DataReceiveButton;
        class ATAK_bnt_VideoFeeds_Click;
        class ATAK_bnt_CFF_Action_Click;
      };
      class ATAK_Menu_Buttons_Init
      {
        file=QPATHTOF(functions\Menu\Init_Buttons);
        class ATAK_bnt_SendMission;
        class ATAK_bnt_CFF_List;
        class ATAK_bnt_Group;
        class ATAK_bnt_TaskBuilding;
        class ATAK_bnt_VideoFeeds;
      };
      class ATAK_Menu_Invokes
      {
        file=QPATHTOF(functions\Menu\Invoke);
        class ATAK_Invoke_ButtonLayoutArrange;
      };
      class ATAK_Menu_onOpened
      {
        file=QPATHTOF(functions\APP_Menu_onOpened);
        class ATAK_mission_Init;
        class ATAK_Group_Init;
        class ATAK_VideoFeeds_Init;
        class ATAK_mission_SUB_TaskBuilding;
        class ATAK_mission_SUB_TaskResult;
        class ATAK_mission_SUB_TaskCFFList;
        class ATAK_mission_SUB_TaskCFF_Action;
      };
      class ATAK_CAM
      {
        file=QPATHTOF(functions\Camera);
        class ATAK_CamInit;
        class ATAK_FullScreenCamera;
      };
      class ATAK_Group_Menu
      {
        file=QPATHTOF(functions\Group);
        class ATAK_GroupList_Init;
        class ATAK_GroupList_SYSTEM_Init;
      };
	};
};