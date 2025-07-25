//- Message Interface
  class ATAK_Message: ATAK_AppMenu_Base
  {
    /*x = phoneSizeX + (phoneSizeW * 3/5);
    y = phoneSizeY;*/
    w = phoneSizeW * 2/5;
    h = phoneSizeH - 0.75 * ATAK_POS_H;

    class controls
    {
      class Title: BCE_RscButtonMenu
      {
        idc = 5;
        x = 0;
        y = 0;
        w = PhoneBFTContainerW(3);
        h = 0.8 * ATAK_POS_H;

        size = 0.7 * ATAK_POS_H;
        text = "";

        colorBackground[] = {0,0,0,0.5};
        colorBackground2[] = {0,0,0,0.5};
        colorBackgroundFocused[] = {0,0,0,0.8};

        animTextureOver = "#(argb,8,8,3)color(1,1,1,0.75)";
        animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
        animTexturePressed = "#(argb,8,8,3)color(1,1,1,0.5)";

        onButtonClick = "call BCE_fnc_ATAK_toggleSubListMenu";
        class Attributes: Attributes
        {
          align = "center";
          valign = "Bottom";
        };
      };
      class Group_Box: cTab_RscControlsGroup
      {
        idc = 10;

        class VScrollbar: VScrollbar
        {
          width = 0;
        };
        class HScrollbar: HScrollbar
        {
          height = 0;
        };
        
        x = 0;
        y = 0.8 * ATAK_POS_H;
        w = PhoneBFTContainerW(3);
        h = phoneSizeH - 2.3 * ATAK_POS_H;
      };
      class Contacts_list: RscListbox
      {
        idc = 6;
        colorBackground[] = {0,0,0,0.3};
        colorSelectBackground[] = {0.95,0.95,0.95,0.4};
        sizeEx = 0.8 * (((60) - (20))) / 2048 * CustomPhoneH;

        x = 0;
        y = 0.8 * ATAK_POS_H;
        w = PhoneBFTContainerW(3);
        h = 0;
      };
      class typing: RscEdit
      {
        idc = 11;
        
        x = 0;
        y = phoneSizeH - 1.5 * ATAK_POS_H;
        w = PhoneBFTContainerW(3);
        h = 0.75 * ATAK_POS_H;

        sizeEx = 0.64 * (((60) - (20))) / 2048 * CustomPhoneH;

        colorBackground[]={0,0,0,0.5};
      };
    };
  };
//- Task Building Page
  #define CATEGORY_H 1
  class Task_Builder: ATAK_Message
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
          y = CATEGORY_H * ATAK_POS_H;
          w = PhoneBFTContainerW(3);
          h = phoneSizeH - ((CATEGORY_H + 0.75) * ATAK_POS_H);
        };
      class ListCategory: ctrlToolboxPictureKeepAspect
      {
        idc = idc_D(2102);
        ATAK_POS(0,0,3,CATEGORY_H);
        colorBackground[] = {0,0,0,0.3};
        rows = 1;
        columns = 3;
        sizeEx = 0.9 * TextSize;
        strings[] =
        {
          "\MG8\AVFEVFX\data\airSupport.paa",
          "\MG8\AVFEVFX\data\artiliry.paa",
          "\MG8\AVFEVFX\data\other_options.paa"
        };
        tooltips[] =
        {
          "Air Fire Support",
          "Ground Fire Support",
          "Others"
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
    #include "\MG8\AVFEVFX\cTab\ATAK_Tools\Mission\AIR.hpp"
    #include "\MG8\AVFEVFX\cTab\ATAK_Tools\Mission\GND.hpp"
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
          size = ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) / TextTimesH;
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
          sizeEx = 0.9 * TextSize;
          // onToolBoxSelChanged = _this + [false,TASK_OFFSET,'cTab_Android_dlg'] call BCE_fnc_ToolBoxChanged;
        };
        // - Sheafs
          class New_Task_IE_Sheaf_Mode: New_Task_IE_Sheaf_Mode
          {
            ATAK_POS(0.1,0.35/2,2.8,0.65);
            sizeEx = 0.9 * TextSize;
          };
          class CFF_IE_Radius_Box: CFF_IE_Radius_Box
          {
            ATAK_POS(0.1,(0.65 + 0.35/2),1.4,0.65);
            sizeEx = 0.9 * TextSize;
          };
          class New_Task_IE_Sheaf_LINE_L: New_Task_IE_Sheaf_LINE_L
          {
            ATAK_POS(0.3,(0.65 + 0.35/2),1.2,0.65);
            sizeEx = 0.9 * TextSize;
          };
          class New_Task_IE_Sheaf_LINE_W: New_Task_IE_Sheaf_LINE_W
          {
            ATAK_POS(0.3,(2*0.65 + 0.35/2),1.2,0.65);
            sizeEx = 0.9 * TextSize;
          };
          class New_Task_IE_Sheaf_LINE_Mil: New_Task_IE_Sheaf_LINE_Mil
          {
            ATAK_POS(0.3,(3*0.65 + 0.35/2),1.2,0.65);
            sizeEx = 0.9 * TextSize;
          };
          class New_Task_IE_Sheaf_LINE_L_T: New_Task_IE_Sheaf_LINE_L_T
          {
            ATAK_POS(0,(0.65 + 0.35/2),0.3,0.65);
            sizeEx = 0.9 * TextSize;
          };
          class New_Task_IE_Sheaf_LINE_W_T: New_Task_IE_Sheaf_LINE_W_T
          {
            ATAK_POS(0,(2*0.65 + 0.35/2),0.3,0.65);
            sizeEx = 0.9 * TextSize;
          };
          class New_Task_IE_Sheaf_LINE_Dir_T: New_Task_IE_Sheaf_LINE_Dir_T
          {
            ATAK_POS(0,(3*0.65 + 0.35/2),0.3,0.65);
            sizeEx = 0.9 * TextSize;
          };
        //- SUPPRESSION Description
          class New_Task_SUP_DESC_Checkboxes: New_Task_SUP_DESC_Checkboxes
          {
            ATAK_POS(0.1,0.35/2,2.8,0.65);
            sizeEx = 0.9 * TextSize;
            onCheckBoxesSelChanged = "[_this#0,_this#1,3] call BCE_fnc_onTaskElementChange;";
          };
          class New_Task_SUP_DESC_Duration: New_Task_SUP_DESC_Duration
          {
            ATAK_POS(0.1,(0.65 + 0.35/2),(2.8/3),0.65);
            sizeEx = 0.9 * TextSize;
            onEditChanged = "[_this#0,0,3] call BCE_fnc_onTaskElementChange;";
          };
          class New_Task_SUP_RND_Interval: New_Task_SUP_RND_Interval
          {
            ATAK_POS((0.1 + (2.8/3)),(0.65 + 0.35/2),(2.8/3),0.65);
            sizeEx = 0.9 * TextSize;
            onEditChanged = "[_this#0,0,3] call BCE_fnc_onTaskElementChange;";
          };
          class New_Task_SUP_DESC_Interval: New_Task_SUP_DESC_Interval
          {
            ATAK_POS((0.1 + 2*(2.8/3)),(0.65 + 0.35/2),(2.8/3/2),0.65);
            sizeEx = 0.9 * TextSize;
            onEditChanged = "[_this#0,0,3] call BCE_fnc_onTaskElementChange;";
          };
          class New_Task_SUP_DESC_MinSec: New_Task_SUP_DESC_MinSec
          {
            ATAK_POS((0.1 + 2*(2.8/3) + (2.8/3/2)),(0.65 + 0.35/2),(2.8/3/2),0.65);
            sizeEx = 0.8 * TextSize;
            onCheckBoxesSelChanged = "[_this#0,0,3] call BCE_fnc_onTaskElementChange;";
          };
          class New_Task_SUP_DESC_SkipAdjust: New_Task_SUP_DESC_SkipAdjust
          {
            ATAK_POS((0.1 + 2*(2.8/3)),(0.35/2 + 3*0.65),(2.8/3),0.65);
            sizeEx = 0.8 * TextSize;
            onCheckBoxesSelChanged = "[_this#0,_this#1,3] call BCE_fnc_onTaskElementChange;";
          };
          class New_Task_CFF_SUP_StructText: New_Task_CFF_SUP_StructText
          {
            ATAK_POS(0.1,(0.35/2 + 0.65*2),2.8,0.65);
            size = TextSize;

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
            sizeEx = 0.8 * TextSize;
          };

        class New_Task_MarkerCombo: New_Task_MarkerCombo
        {
          ATAK_POS(0.1,(0.65 + 0.35/2),1.4,0.65);
          sizeEx = 0.85 * TextSize;

          colorBackground[] = {0.3,0.3,0.3,1};
          colorSelect[]={1,1,1,1};
          colorSelectBackground[]={0.4,0.4,0.4,1};
        };
        class New_Task_IPExpression: New_Task_IPExpression
        {
          ATAK_POS(1.5,(0.65 + 0.35/2),1.4,0.65);
          sizeEx = 0.85 * TextSize;
        };
        //-TG Description
        class New_Task_TGT: New_Task_TGT
        {
          ATAK_POS(0.1,0.35/2,2.8,0.65);
          sizeEx = 0.9 * TextSize;
        };
        class New_Task_GRID_DESC: New_Task_GRID_DESC
        {
          ATAK_POS(0.1,0.35/2,2.8,0.65);
          sizeEx = 0.85 * TextSize;
        };
        class New_Task_GRID_DESC_Air_5line: New_Task_GRID_DESC_Air_5line
        {
          ATAK_POS(0.1,(0.35/2 + 0.65*2),2.8,0.65);
          sizeEx = 0.85 * TextSize;
        };
        class New_Task_FRND_DESC: New_Task_FRND_DESC
        {
          ATAK_POS(0.1,(0.35/2 + 0.65*2),2.8,0.65);
          sizeEx = 0.85 * TextSize;
        };
        class New_Task_EGRS_Azimuth: New_Task_EGRS_Azimuth
        {
          ATAK_POS(0.1,(0.35/2 + 0.65*2),2.8,0.65);
          sizeEx = 0.85 * TextSize;
        };
        class New_Task_EGRS_Bearing: New_Task_EGRS_Bearing
        {
          ATAK_POS(0.1,(0.35/2 + 0.65),1.4,0.65);
          sizeEx = 0.85 * TextSize;
        };
        class New_Task_EGRS: New_Task_EGRS
        {
          ATAK_POS(0.1,0.35/2,2.8,0.65);
          sizeEx = 0.85 * TextSize;
        };
        class New_Task_FADH: New_Task_FADH
        {
          ATAK_POS(0.1,0.35/2,2.8,0.65);
          sizeEx = 0.85 * TextSize;
        };
        class New_Task_DangerClose_Text: New_Task_DangerClose_Text
        {
          ATAK_POS(0.26,(0.3/2 + 0.65*3),2.8,0.65);
          sizeEx = 0.9 * TextSize;
        };
        class New_Task_DangerClose_Box: New_Task_DangerClose_Box
        {
          x = PhoneBFTContainerW(0.1);
          y = (0.35/2 + 0.65*3) * ((60)) / 2048 * CustomPhoneH;
          w = PhoneBFTContainerW(0.3) * (safezoneH/safezonew);
          h = PhoneBFTContainerW(0.3);
        };

        //- Call for Fire
        class New_Task_CFF_CtrlType: New_Task_CFF_CtrlType
        {
          ATAK_POS(0.1,0.35/2,2.8,0.65);
          sizeEx = 0.9 * TextSize;
        };
        class New_Task_CFF_TOT: New_Task_CFF_TOT
        {
          ATAK_POS(0.1,(0.35/2 + 0.65),1.4,0.65);
          sizeEx = 0.85 * TextSize;
        };
        class New_Task_CFF_StructText: New_Task_CFF_StructText
        {
          ATAK_POS(0.1,(0.35/2 + 0.65*2),2.8,0.65);
          size = 0.9 * TextSize;

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
          sizeEx = TextSize;
          soundSelect[]={"\A3\ui_f\data\sound\RscListbox\soundSelect",0,1};
          rowHeight = 0.1 * TextSize;
          
          x = 0;
          y = 0;
          w = PhoneBFTContainerW(3);
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
          sizeEx = 0.9 * TextSize;
          strings[] =
          {
            "MISSION",
            "RECORD"
          };
          tooltips[] =
          {
            "Missions",
            "Recorded Targets"
          };
        };
        class Group_Box: Group_Box
        {
          idc = 10;
          h = phoneSizeH - 1.55 * ATAK_POS_H;
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
            sizeEx = 1.2 * TextSize;
            font = "RobotoCondensed_BCE";
            colorBackground[] = {0,0,0,0.3};
            colorText[]={1,1,1,1};
          };
          class Weapon_T: Page_Title
          {
            text="Weapon";
            ATAK_POS(0,(1 + TITLE_HEIGHT + (0.35/2)),1,0.63);
            tooltip="$STR_BCE_TIP_Weapon";
            sizeEx = TextSize;
            style = 0;
            colorBackground[] = {0,0,0,0};
            colorText[]={1,0.737255,0.0196078,1};
          };
        //- Mission Types
          class MissionType_ADJUST: New_Task_MissionType_ADJUST_CFF
          {
            ATAK_POS(0.1,(TITLE_HEIGHT + (0.35/2)),2.8,0.8);
            sizeEx = TextSize;
            onToolBoxSelChanged = "(['MSN_TYPE'] + _this) call BCE_fnc_CFF_Mission_AutoSaveTask";
          };
        //- Weapon Selections
          //- Style
          #define WPN_COMBO_STYLE \
            colorBackground[] = {0.3,0.3,0.3,1}; \
            colorSelect[]={1,1,1,1}; \
            colorSelectBackground[]={0.4,0.4,0.4,1}; \
            sizeEx = 0.9 * TextSize
          class CFF_IE_WeaponCombo: CFF_IE_WeaponCombo
          {
            WPN_COMBO_STYLE;
            ATAK_POS(0.7,(1 + TITLE_HEIGHT + (0.35/2)),1.5,0.65);
            onLBSelChanged = "(['MSN_WPN|0'] + _this) call BCE_fnc_CFF_Mission_AutoSaveTask; call BCE_fnc_SelWPN_CFF";
          };
          class CFF_IE_FuzeCombo: CFF_IE_FuzeCombo
          {
            WPN_COMBO_STYLE;
            ATAK_POS(2.2,(1 + TITLE_HEIGHT + (0.35/2)),0.7,0.63);
            onLBSelChanged = "(['MSN_WPN|1'] + _this) call BCE_fnc_CFF_Mission_AutoSaveTask";
          };
          class CFF_IE_FireUnit_Combo: CFF_IE_FireUnit_Combo
          {
            WPN_COMBO_STYLE;
            ATAK_POS(0.7,(0.65 + 1 + TITLE_HEIGHT + (0.35/2)),(1.1/2),0.63);
            onLBSelChanged = "(['MSN_WPN|2'] + _this) call BCE_fnc_CFF_Mission_AutoSaveTask";
          };
          class CFF_IE_Round_Box: CFF_IE_Round_Box
          {
            WPN_COMBO_STYLE;
            ATAK_POS((0.7 + (1.1/2)),(0.65 + 1 + TITLE_HEIGHT + (0.35/2)),(1.1/3),0.63);
            onEditChanged = "(['MSN_WPN|3'] + _this) call BCE_fnc_CFF_Mission_AutoSaveTask";
          };
          class CFF_IE_FuzeValue_Box: CFF_IE_FuzeValue_Box
          {
            WPN_COMBO_STYLE;
            ATAK_POS(2.2,(0.65 + 1 + TITLE_HEIGHT + (0.35/2)),0.7,0.63);
            onEditChanged = "(['MSN_WPN|4'] + _this) call BCE_fnc_CFF_Mission_AutoSaveTask";
          };
          class CFF_IE_FireAngle_Bnt: CFF_IE_FireAngle_Bnt
          {
            size = 0.9 * TextSize;
            ATAK_POS(0,(0.65 + 1 + TITLE_HEIGHT + (0.35/2)),0.7,0.63);
            onButtonClick = "(['FIRE_ANGLE'] + _this) call BCE_fnc_CFF_Mission_AutoSaveTask";
          };
          #undef WPN_COMBO_STYLE
        
        #define ADJUSTMENT_MENU 3
        class Adjust_Method: New_Task_Adjust_Method_CFF
        {
          ATAK_POS(0.1,(0.1 + 1 + TITLE_HEIGHT + (2 * 0.7) + (0.35/2)),2.8,0.7);
          sizeEx = 0.8 * TextSize;
        };
        class Adjustments_Group: ATAK_AppMenu_Base
        {
          idc = 5400;
          ATAK_POS(0.1,(0.1 + 1 + TITLE_HEIGHT + (3 * 0.7) + (0.35/2)),2.8,(ADJUSTMENT_MENU * 0.7));
          class controls
          {
            //- Background (for ControlGroup)
              class AdjustFrameBg: RscBackground
              {
                colorBackground[] = {0,0,0,0.2};
                ATAK_POS(0,0,2.8,(ADJUSTMENT_MENU * 0.7));
              };
            //- Clear Button
              class Clear_Adjust: BCE_RscButtonMenu
              {
                idc = 5000;
                ATAK_POS(0,0,0.35,(ADJUSTMENT_MENU * 0.7));

                //- Color
                  colorBackground[] = {1,0,0,0.35};
                  colorBackground2[] = {1,0.25,0.25,0.4};
                  colorBackgroundFocused[] = {1,0,0,0.2};

                  animTextureOver = "#(argb,8,8,3)color(1,1,1,0.75)";
                  animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
                  animTexturePressed = "#(argb,8,8,3)color(1,1,1,0.65)";
                
                size = 0.75 * TextSize;
                style = "0x02 + 0x30 + 0x800";
                shadow = 1;
                text = "<img image='\MG8\AVFEVFX\data\gabage.paa' />";
                onButtonClick = "_this call BCE_fnc_CleanFireAdjustValues";

                class TextPos: TextPos
                {
                  top = (ADJUSTMENT_MENU - 1) * 0.6 * TextSize;
                };
                class Attributes: Attributes
                {
                  align="center";
                  valign="middle";
                  size = TextMenu(1);
                };
              };
            
            //- Adjustment Controls (MACROS)
              #define ADJUST_BNT_OFFSET (1/20)
              #define ADJUST_BNT_X (2.5 - ADJUST_BNT_OFFSET) //- Center of third "ATAK_POS_W"
              #define ADJUST_BNT_W (0.32 + ADJUST_BNT_OFFSET)

              #define ADJUST_INTERVAL 6
              #define ADJUST_BNT_POS(XPOS,YPOS,WPOS,HPOS) \
                x = PhoneBFTContainerW(XPOS) + (((ADJUST_INTERVAL/2) - ADJUST_INTERVAL) * pixelW); \
                y = YPOS * ATAK_POS_H + (ADJUST_INTERVAL / 2 * pixelH); \
                w = PhoneBFTContainerW(WPOS) - (ADJUST_INTERVAL * pixelW); \
                h = HPOS * ATAK_POS_H - (ADJUST_INTERVAL * pixelH)
            
              #define BORDER (2 * ADJUST_BNT_OFFSET) //- Space for L,R borders
              //- Adjustment controls' Width (Higher the bigger Interval)
              #define ADJUST_CTRL_W(BORDER_W) (((1 + BORDER) * ATAK_POS_W) + BORDER_W * ((0.5 + 2) * ADJUST_INTERVAL * pixelW))
            
            //- Middle (Indicators, Adjust...)
              class Indicator: RscPictureKeepAspect
              {
                idc = 5001;

                x = 0.35 * ATAK_POS_W;
                y = 0;
                w = ((2.8 - 0.35) * ATAK_POS_W) - ADJUST_CTRL_W(0.4);
                h = 1.5 * 0.7 * ATAK_POS_H;

                sizeEx = TextSize;

                text = "\MG8\AVFEVFX\data\Arrows\thin_Arrow.paa";
              };
              class Indication: RscStructuredText
              {
                idc = 5002;
                x = 0.35 * ATAK_POS_W;
                y = 1.5 * 0.7 * ATAK_POS_H;
                w = ((2.8 - 0.35) * ATAK_POS_W) - ADJUST_CTRL_W(0.525);
                h = 0.5 * 0.7 * ATAK_POS_H;
                
                colorBackground[] = {0,0,0,0.2};
                size = 0.5 * TextSize;

                text = "<img image='\MG8\AVFEVFX\data\Arrows\Point_Arrow.paa' /> 10 m | <img image='\MG8\AVFEVFX\data\Arrows\Point_Arrow_R.paa' /> 20 m";
                class Attributes
                {
                  font = "RobotoCondensed_BCE";
                  align="center";
                  valign="middle";
                };
              };
              class Adjust_Bnt: BCE_RscButtonMenu
              {
                idc = 5003;

                x = 0.35 * ATAK_POS_W;
                y = 2 * 0.7 * ATAK_POS_H;
                w = ((2.8 - 0.35) * ATAK_POS_W) - ADJUST_CTRL_W(0.525);
                h = 0.7 * ATAK_POS_H;

                //- Style
                  animTextureOver = "#(argb,8,8,3)color(1,1,1,0.75)";
                  animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
                  animTexturePressed = "#(argb,8,8,3)color(1,1,1,0.65)";

                  colorBackground[] = 
                  {
                    "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
                    "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
                    "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
                    0.8
                  };
                  colorBackground2[] = 
                  {
                    "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
                    "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
                    "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
                    0.8
                  };
                  colorBackgroundFocused[] = 
                  {
                    "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])",
                    "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])",
                    "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",
                    0.5
                  };

                shadow=1;
                size = TextSize;
                text = "<img image='\MG8\AVFEVFX\data\ruler.paa' /> ADJUST";
                onButtonClick = "['MSN_ADJUST_POLAR',nil,_this#0] call BCE_fnc_set_FireAdjust_MSN_State";

                class TextPos: TextPos
                {
                  top = 0.1 * ATAK_POS_H;
                };
                class Attributes: Attributes
                {
                  align="center";
                  valign="middle";
                  size = TextMenu(0.8);
                };
              };

            //- Adjust Buttons -//
              //- Background
                class AdjustBg: AdjustFrameBg
                {
                  x = ((2.5 - BORDER) - 2 * ADJUST_BNT_W) * ATAK_POS_W + (((ADJUST_INTERVAL/2) - ADJUST_INTERVAL) * pixelW);
                  y = 0;
                  w = ADJUST_CTRL_W(1);
                  h = 3 * 0.7 * ATAK_POS_H;
                };
              class Adjust_Meter: ctrlButton
              {
                idc = 5004;
                
                x = ((2.5 - BORDER) - 2 * ADJUST_BNT_W) * ATAK_POS_W + (((ADJUST_INTERVAL/2) - ADJUST_INTERVAL) * pixelW);
                y = 0;
                w = ADJUST_CTRL_W(1);
                h = 0.7 * ATAK_POS_H;

                //- Color
                  colorBackground[] = {0,0,0,0.3};
                
                font = "RobotoCondensed_BCE";
                sizeEx = 0.8 * TextSize;
                text = "<-- 10 m -->";
                onButtonClick = "call BCE_fnc_ATAK_FireAdjustMeter";
              };
              //- Undef "BORDER", "ADJUST_CTRL_W"
                #undef BORDER
                #undef ADJUST_CTRL_W
              class Adjust_Up: ctrlButtonPictureKeepAspect
              {
                idc = 5100;
                ADJUST_BNT_POS((ADJUST_BNT_X - ADJUST_BNT_W),(1 * 0.7),ADJUST_BNT_W,0.7);

                //- Color
                  colorBackground[] = {0,0,0.2,0.3};
                
                sizeEx = 0.5 * TextSize;
                text = "\MG8\AVFEVFX\data\Arrows\Point_Arrow.paa";
                onButtonClick = "[_this # 0, [0,1]] call BCE_fnc_UpdateFireAdjust";
              };
              class Adjust_Dn: Adjust_Up
              {
                idc = 5101;
                ADJUST_BNT_POS((ADJUST_BNT_X - ADJUST_BNT_W),(2 * 0.7),ADJUST_BNT_W,0.7);
                text = "\MG8\AVFEVFX\data\Arrows\Point_Arrow_D.paa";
                onButtonClick = "[_this # 0, [0,-1]] call BCE_fnc_UpdateFireAdjust";
              };
              class Adjust_L: Adjust_Up
              {
                idc = 5102;
                ADJUST_BNT_POS((ADJUST_BNT_X - 2 * ADJUST_BNT_W),(2 * 0.7),ADJUST_BNT_W,0.7);
                text = "\MG8\AVFEVFX\data\Arrows\Point_Arrow_L.paa";
                onButtonClick = "[_this # 0, [-1,0]] call BCE_fnc_UpdateFireAdjust";
              };
              class Adjust_R: Adjust_Up
              {
                idc = 5103;
                ADJUST_BNT_POS((ADJUST_BNT_X),(2 * 0.7),ADJUST_BNT_W,0.7);
                text = "\MG8\AVFEVFX\data\Arrows\Point_Arrow_R.paa";
                onButtonClick = "[_this # 0, [1,0]] call BCE_fnc_UpdateFireAdjust";
              };
              #undef ADJUST_BNT_OFFSET
              #undef ADJUST_BNT_X
              #undef ADJUST_BNT_W
              #undef ADJUST_INTERVAL
              #undef ADJUST_BNT_POS
          };
        };

        class New_Task_MTO_Display: New_Task_MTO_Display
        {
          ATAK_POS(0.1,(2 * (0.35/2) + 0.1 + 1 + TITLE_HEIGHT + ((ADJUSTMENT_MENU + 3) * 0.7)),2.8,(2 * 0.7));
          size = TextSize;
          tooltip = "Send back from FDC.";
          class Attributes: Attributes
          {
            align = "center";
            size = 0.65;
          };
        };
        class New_Task_OtherInfo_Display: New_Task_OtherInfo_Display
        {
          ATAK_POS(0.1,(2 * (0.35/2) + 0.1 + 1 + TITLE_HEIGHT + ((ADJUSTMENT_MENU + 3 + 2) * 0.7)),2.8,0.6);
          size = TextSize;
          tooltip = "Other Infos";
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
//- Video Feeds Interface
  #define EMPT_SPAC (0.15 * ((60)) / 2048 * CustomPhoneH)
  class ATAK_Video: ATAK_Message
  {
    class controls
    {
      class Title: BCE_RscButtonMenu
      {
        idc = 5;
        
        x = 0;
        y = 0;
        w = PhoneBFTContainerW(3);
        h = 0.8 * ATAK_POS_H;
        
        size = 0.7 * ATAK_POS_H;
        text = "";

        colorBackground[] = {0,0,0,0.5};
        colorBackground2[] = {0,0,0,0.5};
        colorBackgroundFocused[] = {0,0,0,0.5};

        animTextureOver = "#(argb,8,8,3)color(1,1,1,0.75)";
        animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
        animTexturePressed = "#(argb,8,8,3)color(1,1,1,0.5)";

        onButtonClick = "call BCE_fnc_ATAK_toggleSubListMenu";
        class Attributes: Attributes
        {
          align = "center";
          valign = "Bottom";
        };
      };
      //- Sel Other Camera (Helmet, TGP etc)
      class CamSelBox: cTab_RscControlsGroup
      {
        idc = 10;
        //- Scroll
          class VScrollbar: VScrollbar
          {
            width = 0;
          };
          class HScrollbar: HScrollbar
          {
            height = 0;
          };
        x = 0;
        y = 0.8 * ATAK_POS_H;
        w = PhoneBFTContainerW(3);
        h = 0;

        class controls
        {
          class Type: RscToolbox
          {
            idc = 6;
            
            x = PhoneBFTContainerW(0.05);
            y = EMPT_SPAC;
            w = PhoneBFTContainerW(2.9);
            h = ((phoneSizeW * 3/5)/3 - (0.8 * ATAK_POS_H) - (0.85 * TextSize)) / 2 - EMPT_SPAC;

            rows = 1;
            columns = 2;
            strings[] =
            {
              "$STR_BCE_AC_CAM",
              "$STR_BCE_Helmet_CAM"
            };
            font = "RobotoCondensed_BCE";
            colorBackground[] = {0,0,0,0.3};
            sizeEx = 0.8 * TextSize;
          };
          class List: RscListbox
          {
            idc = 7;
            colorBackground[]={0,0,0,0.8};
            sizeEx = TextSize;

            x = 0;
            y = ((phoneSizeW * 3/5)/3 - (0.8 * ATAK_POS_H) - (0.85 * TextSize)) / 2 + EMPT_SPAC;
            w = PhoneBFTContainerW(3);
            h = phoneSizeH - (0.75 + 0.8) * ATAK_POS_H - ((phoneSizeW * 3/5)/3 - (0.8 * ATAK_POS_H) - (0.85 * TextSize)) / 2;
          };
        };
      };
      class ViewBox: CamSelBox
      {
        idc = 20;
        h = phoneSizeH - (0.75 + 0.8) * ATAK_POS_H;
        class controls
        {
          // - Turret Infos + Optional Controls
            class Track_TG: Title
            {
              idc = 11;
              text = "$STR_BCE_TRACK_TG";
              
              colorBackground[] = {0,0,0.5,0.3};
              colorBackground2[] = {0,0,0.5,0.3};
              colorBackgroundFocused[] = {0,0,0,0.3};

              size = 0.8 * TextSize;

              x = PhoneBFTContainerW(0.05);
              y = EMPT_SPAC;
              w = PhoneBFTContainerW(1.45);
              h = ((phoneSizeW * 3/5)/3 - (0.8 * ATAK_POS_H) - (0.85 * TextSize)) / 2 - EMPT_SPAC;

              onButtonClick = "[_this#0,0] call BCE_fnc_ATAK_Camera_Controls";
            };
            class TG_INFO: RscText
            {
              idc = 12;

              style = 2;
              text = "";
              sizeEx = 0.8 * TextSize;
              colorBackground[]={0,0,0,0.2};

              x = PhoneBFTContainerW(0.05);
              y = EMPT_SPAC + ((phoneSizeW * 3/5)/3 - (0.8 * ATAK_POS_H) - (0.85 * TextSize)) / 2;
              w = PhoneBFTContainerW(1.45);
              h = ((phoneSizeW * 3/5)/3 - (0.8 * ATAK_POS_H) - (0.85 * TextSize)) / 2 - EMPT_SPAC;
            };
            class Vision: Track_TG
            {
              idc = 13;
              text = "";
              
              x = PhoneBFTContainerW(1.55);
              onButtonClick = "[_this#0,1] call BCE_fnc_ATAK_Camera_Controls";
            };
            class Sync_Camera: Vision
            {
              idc = 14;
              text = "$STR_BCE_Sync_Zoom";
              
              y = EMPT_SPAC + ((phoneSizeW * 3/5)/3 - (0.8 * ATAK_POS_H) - (0.85 * TextSize)) / 2;
              onButtonClick = "[_this#0,2] call BCE_fnc_ATAK_Camera_Controls";
            };
          // - Next Turret
            class TurretTxt: ctrlButton
            {
              idc = 46320;
              text = "";
              colorBackground[] = {0.25,0.25,0.25,0.8};
              colorBackgroundActive[] = {0.25,0.25,0.25,0.4};
              colorBackgroundDisabled[] = {0.25,0.25,0.25,0.8};
              colorDisabled[] = {1,1,1,1};

              x = 0;
              y = EMPT_SPAC + ((phoneSizeW * 3/5)/3 - 0.8 * ATAK_POS_H) - (0.85 * TextSize);
              w = PhoneBFTContainerW(3);
              h = 0.85 * TextSize;
              sizeEx = 0.75 * TextSize;

              font = "RobotoCondensed_BCE";
              colorShadow[] = {0,0,0,0.2};

              offsetPressedX = 0;
              offsetPressedY = 0;
              
              onButtonClick = "[_this # 0,17000] call BCE_fnc_NextTurretButton;";
            };
          // - Video Layer
            class Vic_PIP_Display: RscPicture
            {
              idc = 4632;
              text = "#(argb,512,512,1)r2t(rendertarget9,1.1896551724)";
              x = 0;
              y = EMPT_SPAC + ((phoneSizeW * 3/5)/3 - 0.8 * (60 / 2048 * CustomPhoneH));
              w = PhoneBFTContainerW(3);
              h = phoneSizeH - EMPT_SPAC - 0.75 * ATAK_POS_H - (phoneSizeW * 3/5)/3;
            };
            class Vic_PIP_No_Signal: TurretTxt
            {
              idc = 46310;

              x = 0;
              y = EMPT_SPAC + ((phoneSizeW * 3/5)/3 - 0.8 * (60 / 2048 * CustomPhoneH));
              w = PhoneBFTContainerW(3);
              h = phoneSizeH - EMPT_SPAC - 0.75 * ATAK_POS_H - (phoneSizeW * 3/5)/3;
              
              style = 2;
              text = "$STR_BCE_No_Signal";
              colorBackground[]={0,0,0,0.4};
              colorBackgroundActive[] = {0,0,0,0.2};
              colorBackgroundDisabled[] = {0,0,0,0.4};
              colorDisabled[] = {1,1,1,0.25};

              onButtonClick = "";
              action = "call cTab_Tablet_btnACT";
            };
        };
      };
    };
  };
  #undef EMPT_SPAC
//- Group Manage
  class ATAK_Group: ATAK_Message
  {
    class controls: controls
    {
      class Title: Title
      {
        idc = 5;
        text = "Group";
        w = PhoneBFTContainerW(2.4);
      };
      class New_Grp: Title
      {
        idc = 6;
        style = "0x02 + 0x0C + 0x0100";
        shadow = 1;
        text = "<img image='MG8\AVFEVFX\data\add.paa' />";

        x = PhoneBFTContainerW(2.4);
        w = PhoneBFTContainerW(0.6);
        
        onButtonClick = "";
      };

      class Group_Box: Group_Box
      {
        idc = 10;
        h = phoneSizeH - 1.55 * ATAK_POS_H;
      };
    };
  };
