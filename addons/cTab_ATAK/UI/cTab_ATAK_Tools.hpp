//- Message Interface
	class ATAK_Message
	{
		class controls
		{
			class Title;
			class Group_Box;
		};
	};
//- Task Building Page
  #define CATEGORY_H 1
  class Task_Builder: ATAK_AppMenu_Base
  {
    class controls
    {
      //- Background (for ControlGroup)
        class Background: RscBackground
        {
          idc = 20;
          text="";
          colorBackground[] = {0,0,0.5,0.1};
          x = 0;
          y = QUOTE(CATEGORY_H * ATAK_POS_H);
          w = QUOTE(PhoneBFTContainerW(3));
          h = QUOTE(phoneSizeH - ((CATEGORY_H + 0.75) * ATAK_POS_H));
        };
      class ListCategory: ctrlToolboxPictureKeepAspect
      {
        idc = idc_D(2102);
        ATAK_POS(0,0,3,CATEGORY_H);
        colorBackground[] = {0,0,0,0.3};
        rows = 1;
        columns = 3;
        sizeEx = QUOTE(0.9 * TextSize);
        strings[] =
        {
					QPATHTOEF(Core,data\airSupport.paa),
					QPATHTOEF(Core,data\artiliry.paa),
					QPATHTOEF(Core,data\other_options.paa)
        };
        tooltips[] =
        {
          "$STR_BCE_TASK_Categories_AIR",
          "$STR_BCE_TASK_Categories_GND",
          "$STR_BCE_TASK_Categories_OTR"
        };

        //- Connects to => "BCE_Mission_Property" Category
        data[] = {
          "AIR", //- Air
          "GND", //- Ground
          "OTR"  //- Others
        };
      };
    };
  };
  //- TASK GROUPs (9 Line, 5 Line etc)
    #include "Mission\AIR.hpp"
    #include "Mission\GND.hpp"
  #undef CATEGORY_H
  //- Task building Components
    class Task_Building: Task_Builder
    {
      class VScrollbar
      {
        scrollSpeed=0;
      };
      
      //- Inherit from #LINK - cTab/ATAK_Tools/cTab_ATAK_Tools.hpp
      class controls: BCE_Mission_Build_Controls
      {
        class taskDesc: taskDesc
        {
          ATAK_POS(0,0,3,1);
          size = QUOTE(((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) / TextTimesH);
          class Attributes: Attributes
          {
            size = TextMenu(0.95);
          };
        };
        
        /*class Indicator: RscText
        {
          idc = idc_D(2011);
          
          x = PhoneBFTContainerW(0.1);
          y = 0.1 * ((60)) / 2048 * CustomPhoneH;
          w = PhoneBFTContainerW(3);
          h = phoneSizeH - 0.75 * ATAK_POS_H;
        };*/
        class New_Task_IPtype: New_Task_IPtype
        {
          ATAK_POS(0.1,0.35/2,2.8,0.65);
          sizeEx = QUOTE(0.9 * TextSize);
          // onToolBoxSelChanged = _this + [false,TASK_OFFSET,'cTab_Android_dlg'] call BCE_fnc_ToolBoxChanged;
        };
        // - Sheafs
          class New_Task_IE_Sheaf_Mode: New_Task_IE_Sheaf_Mode
          {
            ATAK_POS(0.1,0.35/2,2.8,0.65);
            sizeEx = QUOTE(0.9 * TextSize);
          };
          class New_Task_CFF_SHEAF_StructText: New_Task_CFF_SHEAF_StructText
          {
						ATAK_POS(1.5,(2*0.65 + 0.35/2),1.4,0.65);
						size = QUOTE(TextSize);

            class Attributes: Attributes
            {
              size = 0.8;
              color = "#dddddd";
              align = "center";
              valign = "middle";
            };
          };
          class CFF_IE_Radius_Box: CFF_IE_Radius_Box
          {
            ATAK_POS(0.1,(0.65 + 0.35/2),1.4,0.65);
            sizeEx = QUOTE(0.9 * TextSize);
          };
          class New_Task_IE_Sheaf_LINE_L: New_Task_IE_Sheaf_LINE_L
          {
            ATAK_POS(0.3,(0.65 + 0.35/2),1.2,0.65);
            sizeEx = QUOTE(0.9 * TextSize);
          };
          class New_Task_IE_Sheaf_LINE_W: New_Task_IE_Sheaf_LINE_W
          {
            ATAK_POS(0.3,(2*0.65 + 0.35/2),1.2,0.65);
            sizeEx = QUOTE(0.9 * TextSize);
          };
          class New_Task_IE_Sheaf_LINE_Mil: New_Task_IE_Sheaf_LINE_Mil
          {
            ATAK_POS(0.3,(3*0.65 + 0.35/2),1.2,0.65);
            sizeEx = QUOTE(0.9 * TextSize);
          };
          class New_Task_IE_Sheaf_LINE_L_T: New_Task_IE_Sheaf_LINE_L_T
          {
            ATAK_POS(0,(0.65 + 0.35/2),0.3,0.65);
            sizeEx = QUOTE(0.9 * TextSize);
          };
          class New_Task_IE_Sheaf_LINE_W_T: New_Task_IE_Sheaf_LINE_W_T
          {
            ATAK_POS(0,(2*0.65 + 0.35/2),0.3,0.65);
            sizeEx = QUOTE(0.9 * TextSize);
          };
          class New_Task_IE_Sheaf_LINE_Dir_T: New_Task_IE_Sheaf_LINE_Dir_T
          {
            ATAK_POS(0,(3*0.65 + 0.35/2),0.3,0.65);
            sizeEx = QUOTE(0.9 * TextSize);
          };
        //- SUPPRESSION Description
          class New_Task_SUP_DESC_Checkboxes: New_Task_SUP_DESC_Checkboxes
          {
            ATAK_POS(0.1,0.35/2,2.8,0.65);
            sizeEx = QUOTE(0.9 * TextSize);
            onCheckBoxesSelChanged = "[_this#0,_this#1,3] call BCE_fnc_onTaskElementChange;";
          };
          class New_Task_SUP_DESC_Duration: New_Task_SUP_DESC_Duration
          {
            ATAK_POS(0.1,(0.65 + 0.35/2),(2.8/3),0.65);
            sizeEx = QUOTE(0.9 * TextSize);
            onEditChanged = "[_this#0,0,3] call BCE_fnc_onTaskElementChange;";
          };
          class New_Task_SUP_RND_Interval: New_Task_SUP_RND_Interval
          {
            ATAK_POS((0.1 + (2.8/3)),(0.65 + 0.35/2),(2.8/3),0.65);
            sizeEx = QUOTE(0.9 * TextSize);
            onEditChanged = "[_this#0,0,3] call BCE_fnc_onTaskElementChange;";
          };
          class New_Task_SUP_DESC_Interval: New_Task_SUP_DESC_Interval
          {
            ATAK_POS((0.1 + 2*(2.8/3)),(0.65 + 0.35/2),(2.8/3/2),0.65);
            sizeEx = QUOTE(0.9 * TextSize);
            onEditChanged = "[_this#0,0,3] call BCE_fnc_onTaskElementChange;";
          };
          class New_Task_SUP_DESC_MinSec: New_Task_SUP_DESC_MinSec
          {
            ATAK_POS((0.1 + 2*(2.8/3) + (2.8/3/2)),(0.65 + 0.35/2),(2.8/3/2),0.65);
            sizeEx = QUOTE(0.8 * TextSize);
            onCheckBoxesSelChanged = "[_this#0,0,3] call BCE_fnc_onTaskElementChange;";
          };
          class New_Task_SUP_DESC_SkipAdjust: New_Task_SUP_DESC_SkipAdjust
          {
            ATAK_POS((0.1 + 2*(2.8/3)),(0.35/2 + 3*0.65),(2.8/3),0.65);
            sizeEx = QUOTE(0.8 * TextSize);
            onCheckBoxesSelChanged = "[_this#0,_this#1,3] call BCE_fnc_onTaskElementChange;";
          };
          class New_Task_CFF_SUP_StructText: New_Task_CFF_SUP_StructText
          {
            ATAK_POS(0.1,(0.35/2 + 0.65*2),2.8,0.65);
            size = QUOTE(TextSize);

            class Attributes: Attributes
            {
              size = 0.8;
              color = "#dddddd";
              align = "center";
              valign = "middle";
            };
          };
          class New_Task_Expression_CFF: New_Task_Expression_CFF
          {
            ATAK_POS(0.1,(0.35/2 + 3*0.65),(2*(2.8/3)),0.65);
            sizeEx = QUOTE(0.8 * TextSize);
          };

        class New_Task_MarkerCombo: New_Task_MarkerCombo
        {
          ATAK_POS(0.1,(0.65 + 0.35/2),1.4,0.65);
          sizeEx = QUOTE(0.85 * TextSize);

          colorBackground[] = {0.3,0.3,0.3,1};
          colorSelect[]={1,1,1,1};
          colorSelectBackground[]={0.4,0.4,0.4,1};
        };
        class New_Task_IPExpression: New_Task_IPExpression
        {
          ATAK_POS(1.5,(0.65 + 0.35/2),1.4,0.65);
          sizeEx = QUOTE(0.85 * TextSize);
        };
        //-TG Description
        class New_Task_TGT: New_Task_TGT
        {
          ATAK_POS(0.1,0.35/2,2.8,0.65);
          sizeEx = QUOTE(0.9 * TextSize);
        };
        class New_Task_GRID_DESC: New_Task_GRID_DESC
        {
          ATAK_POS(0.1,0.35/2,2.8,0.65);
          sizeEx = QUOTE(0.85 * TextSize);
        };
        class New_Task_GRID_DESC_Air_5line: New_Task_GRID_DESC_Air_5line
        {
          ATAK_POS(0.1,(0.35/2 + 0.65*2),2.8,0.65);
          sizeEx = QUOTE(0.85 * TextSize);
        };
        class New_Task_FRND_DESC: New_Task_FRND_DESC
        {
          ATAK_POS(0.1,(0.35/2 + 0.65*2),2.8,0.65);
          sizeEx = QUOTE(0.85 * TextSize);
        };
        class New_Task_EGRS_Azimuth: New_Task_EGRS_Azimuth
        {
          ATAK_POS(0.1,(0.35/2 + 0.65*2),2.8,0.65);
          sizeEx = QUOTE(0.85 * TextSize);
        };
        class New_Task_EGRS_Bearing: New_Task_EGRS_Bearing
        {
          ATAK_POS(0.1,(0.35/2 + 0.65),1.4,0.65);
          sizeEx = QUOTE(0.85 * TextSize);
        };
        class New_Task_EGRS: New_Task_EGRS
        {
          ATAK_POS(0.1,0.35/2,2.8,0.65);
          sizeEx = QUOTE(0.85 * TextSize);
        };
        class New_Task_FADH: New_Task_FADH
        {
          ATAK_POS(0.1,0.35/2,2.8,0.65);
          sizeEx = QUOTE(0.85 * TextSize);
        };
        class New_Task_DangerClose_Text: New_Task_DangerClose_Text
        {
          ATAK_POS(0.26,(0.3/2 + 0.65*3),2.8,0.65);
          sizeEx = QUOTE(0.9 * TextSize);
        };
        class New_Task_DangerClose_Box: New_Task_DangerClose_Box
        {
          x = QUOTE(PhoneBFTContainerW(0.1));
          y = QUOTE((0.35/2 + 0.65*3) * ((60)) / 2048 * CustomPhoneH);
          w = QUOTE(PhoneBFTContainerW(0.3) * (safezoneH/safezonew));
          h = QUOTE(PhoneBFTContainerW(0.3));
        };

        //- Call for Fire
        class New_Task_CFF_CtrlType: New_Task_CFF_CtrlType
        {
          ATAK_POS(0.1,0.35/2,2.8,0.65);
          sizeEx = QUOTE(0.9 * TextSize);
        };
        class New_Task_CFF_TOT: New_Task_CFF_TOT
        {
          ATAK_POS(0.1,(0.35/2 + 0.65),1.4,0.65);
          sizeEx = QUOTE(0.85 * TextSize);
        };
        class New_Task_CFF_StructText: New_Task_CFF_StructText
        {
          ATAK_POS(0.1,(0.35/2 + 0.65*2),2.8,0.65);
          size = QUOTE(0.9 * TextSize);

          class Attributes: Attributes
          {
            size = 0.9;
            align = "center";
            valign = "Middle";
          };
        };
      };
    };
    //- Task Result
    class Task_Result: Task_Building
    {
      class controls
      {
        class taskDesc: RscListBox
        {
          idc = 11;
          shadow = 2;
          
          colorBackground[] = {0,0,0,0};
          period = 0;
          colorSelect[] = {1,1,1,1};
          colorSelect2[] = {1,1,1,1};
          colorSelectRight[] = {1,1,1,1};
          colorSelect2Right[] = {1,1,1,1};
          colorSelectBackground[] = {0,0,0,0};
          colorSelectBackground2[] = {0,0,0,0};
          
          font = "RobotoCondensed_BCE";
          sizeEx = QUOTE(TextSize);
          soundSelect[]={"\A3\ui_f\data\sound\RscListbox\soundSelect",0,1};
          rowHeight = QUOTE(0.1 * TextSize);
          
          x = 0;
          y = 0;
          w = QUOTE(PhoneBFTContainerW(3));
          h = "SafezoneH";
        };
      };
    };

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
					onToolBoxSelChanged = "call BCE_fnc_ATAK_FireAdjust_Sel_Changed";
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
//- Group Manage
  class ATAK_Group: ATAK_Message
  {
    class controls: controls
    {
      class Title: Title
      {
        idc = 5;
        text = "Group";
        w = QUOTE(PhoneBFTContainerW(2.4));
      };
      class New_Grp: Title
      {
        idc = 6;
        style = "0x02 + 0x0C + 0x0100";
        shadow = 1;
        // text = "<img image='MG8\AVFEVFX\data\add.paa' />";
        text = QSTRUCTURE_IMAGE(Core,data\add.paa);

        x = QUOTE(PhoneBFTContainerW(2.4));
        w = QUOTE(PhoneBFTContainerW(0.6));
        
        onButtonClick = "";
      };

      class Group_Box: Group_Box
      {
        idc = 10;
        h = QUOTE(phoneSizeH - 1.55 * ATAK_POS_H);
      };
    };
  };
