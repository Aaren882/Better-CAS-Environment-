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
      class ATAK_Menu_Invokes
      {
        file=QPATHTOF(functions\Menu\Invoke);
        class ATAK_Invoke_ButtonLayoutArrange;
      };
      class ATAK_CAM
      {
        file=QPATHTOF(functions\Camera);
        class ATAK_CamInit;
        class ATAK_FullScreenCamera;
      };
	};
};