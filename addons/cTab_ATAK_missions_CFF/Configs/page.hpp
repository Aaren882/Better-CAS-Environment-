class ATAK_AppMenu_Base;

//- Message Interface
	class ATAK_Message: ATAK_AppMenu_Base
	{
		class controls
		{
			class Title;
			class Group_Box;
		};
	};

//- Task Building Page
  ///- CFF Pages -//
    class Task_CFF_List: ATAK_Message
    {
      class controls: controls
      {
        class ListCategory: RscToolbox
        {
          idc = idc_D(2102);
          ATAK_POS(0,0,3,0.8);
          colorBackground[] = {0,0,0,0.3};
          rows = 1;
          columns = 2;
          sizeEx = QUOTE(0.9 * TextSize);
          strings[] =
          {
            "$STR_BCE_MISSION",
            "$STR_BCE_RECORD"
          };
          tooltips[] =
          {
            "$STR_BCE_MISSION_Tip",
            "$STR_BCE_RECORD_Tip"
          };
        };
        class Group_Box: Group_Box
        {
          idc = 10;
          h = QUOTE(phoneSizeH - 1.55 * ATAK_POS_H);
        };
      };
    };
    class Task_CFF_Action: Task_CFF_List
    {
      class controls: BCE_Mission_Build_Controls
      {
        #define TITLE_HEIGHT 1
        //- Titles
          class Page_Title: RscText
          {
            text="Mission #NA";
            ATAK_POS(0,0,3,TITLE_HEIGHT);
            tooltip="";

            idc = 3600;
            shadow=2;
            style = 0x02 + 0xC0;
            sizeEx = QUOTE(1.2 * TextSize);
            font = "RobotoCondensed_BCE";
            colorBackground[] = {0,0,0,0.3};
            colorText[]={1,1,1,1};
          };
          class Weapon_T: Page_Title
          {
            text="Weapon";
            ATAK_POS(0,(1 + TITLE_HEIGHT + (0.35/2)),1,0.63);
            tooltip="$STR_BCE_TIP_Weapon";
            sizeEx = QUOTE(TextSize);
            style = 0;
            colorBackground[] = {0,0,0,0};
            colorText[]={1,0.737255,0.0196078,1};
          };
        //- Mission Types
          class New_Task_MissionType_ADJUST_CFF: New_Task_MissionType_ADJUST_CFF
          {
            ATAK_POS(0.1,(TITLE_HEIGHT + (0.35/2)),2.8,0.8);
            sizeEx = QUOTE(TextSize);
            onToolBoxSelChanged = "['MSN_TYPE',_this] call BCE_fnc_CFF_Mission_AutoSaveTask";
          };
        //- Weapon Selections
          //- Style
          #define WPN_COMBO_STYLE \
            colorBackground[] = {0.3,0.3,0.3,1}; \
            colorSelect[]={1,1,1,1}; \
            colorSelectBackground[]={0.4,0.4,0.4,1}; \
            sizeEx = QUOTE(0.9 * TextSize)
          class CFF_IE_WeaponCombo: CFF_IE_WeaponCombo
          {
            WPN_COMBO_STYLE;
            ATAK_POS(0.7,(1 + TITLE_HEIGHT + (0.35/2)),1.5,0.65);
            onLBSelChanged = "['MSN_WPN|0',_this] call BCE_fnc_CFF_Mission_AutoSaveTask; call BCE_fnc_SelWPN_CFF";
          };
          class CFF_IE_FuzeCombo: CFF_IE_FuzeCombo
          {
            WPN_COMBO_STYLE;
            ATAK_POS(2.2,(1 + TITLE_HEIGHT + (0.35/2)),0.7,0.63);
            onLBSelChanged = "['MSN_WPN|1',_this] call BCE_fnc_CFF_Mission_AutoSaveTask";
          };
          class CFF_IE_FireUnit_Combo: CFF_IE_FireUnit_Combo
          {
            WPN_COMBO_STYLE;
            ATAK_POS(0.7,(0.65 + 1 + TITLE_HEIGHT + (0.35/2)),(1.1/2),0.63);
            onLBSelChanged = "['MSN_WPN|2',_this] call BCE_fnc_CFF_Mission_AutoSaveTask";
          };
          class CFF_IE_Round_Box: CFF_IE_Round_Box
          {
            WPN_COMBO_STYLE;
            ATAK_POS((0.7 + (1.1/2)),(0.65 + 1 + TITLE_HEIGHT + (0.35/2)),(1.1/3),0.63);
            onEditChanged = "['MSN_WPN|3',_this] call BCE_fnc_CFF_Mission_AutoSaveTask";
          };
          class CFF_IE_FuzeValue_Box: CFF_IE_FuzeValue_Box
          {
            WPN_COMBO_STYLE;
            ATAK_POS(2.2,(0.65 + 1 + TITLE_HEIGHT + (0.35/2)),0.7,0.63);
            onEditChanged = "['MSN_WPN|4',_this] call BCE_fnc_CFF_Mission_AutoSaveTask";
          };
          class CFF_IE_FireAngle_Bnt: CFF_IE_FireAngle_Bnt
          {
            size = QUOTE(0.9 * TextSize);
            ATAK_POS(0,(0.65 + 1 + TITLE_HEIGHT + (0.35/2)),0.7,0.63);
            onButtonClick = "['FIRE_ANGLE',_this] call BCE_fnc_CFF_Mission_AutoSaveTask";
          };
          #undef WPN_COMBO_STYLE
        
        #define ADJUSTMENT_MENU 3
        class New_Task_Adjust_Method_CFF: New_Task_Adjust_Method_CFF
        {
          ATAK_POS(0.1,(0.1 + 1 + TITLE_HEIGHT + (2 * 0.7) + (0.35/2)),2.8,0.7);
          sizeEx = QUOTE(0.8 * TextSize);
					onToolBoxSelChanged = QUOTE(call FUNC(ATAK_FireAdjust_Sel_Changed));
        };

				//- #ANCHOR - ADJUSTMENT INTERFACE
				class ADJUST_MENUS: ATAK_AppMenu_Base
				{
					idc = 5400;
					ATAK_POS(0.1,(0.1 + 1 + TITLE_HEIGHT + (3 * 0.7) + (0.35/2)),2.8,(ADJUSTMENT_MENU * 0.7));
				};

        class New_Task_MTO_Display: New_Task_MTO_Display
        {
          ATAK_POS(0.1,(2 * (0.35/2) + 0.1 + 1 + TITLE_HEIGHT + ((ADJUSTMENT_MENU + 3) * 0.7)),2.8,(2 * 0.7));
          size = QUOTE(TextSize);
          class Attributes: Attributes
          {
            align = "center";
            size = 0.65;
          };
        };
        class New_Task_OtherInfo_Display: New_Task_OtherInfo_Display
        {
          ATAK_POS(0.1,(2 * (0.35/2) + 0.1 + 1 + TITLE_HEIGHT + ((ADJUSTMENT_MENU + 3 + 2) * 0.7)),2.8,0.6);
          size = QUOTE(TextSize);
          shadow = 2;
          class Attributes: Attributes
          {
            valign="middle";
            align = "center";
            size = 0.75;
          };
        };
        #undef ADJUSTMENT_MENU
        #undef TITLE_HEIGHT
      };
    };
