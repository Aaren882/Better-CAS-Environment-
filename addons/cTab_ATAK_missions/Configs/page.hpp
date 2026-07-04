class ATAK_AppMenu_Base;

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
