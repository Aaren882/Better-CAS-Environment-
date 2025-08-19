/*
  This file is used to define the controls used in the mission building.

  [X, Y, W, H] are defined in the UI that uses this Config.
  [size, SizeEx] Also
*/
#define PROP_IDC_OFFSET 30000
#define PROP_IDC(IDC) __EVAL(PROP_IDC_OFFSET + IDC)
#define REGISTER_FNC \
  onLoad = "call BCE_fnc_RegisterMissionControls"

class BCE_Mission_Build_Controls
{
  //- BCE Mission Holder
    class BCE_Holder: RscText
    {
      onLoad = "call BCE_fnc_onLoad_BCE_Holder";

      idc = PROP_IDC(2000);
      x = 0;
      y = 0;
      w = 0;
      h = 0;

      //- Default Values
      class BCE_Mission: BCE_Mission_Default{};
    };
  
  //- Map Control
    class Rsc_BCE_MapControl: RscMapControl
    {
      onLoad = "call BCE_fnc_onLoad_BCE_Map_Holder";
      idc = PROP_IDC(1100);
      class BCE_Map_Events //- #NOTE - use SQF UI addEventhandlers
      {
        onMouseButtonClick = "";
        onMouseButtonDblClick = "";
      };
    };
    //- cTab only 
    // 🔴 #NOTE - "controlBackground" have to inherit "BCE_Mission_Build_Controls" 
    /* #ifdef cTAB_Installed
      class cTab_RscMapControl: cTab_RscMapControl
      {
        REGISTER_FNC;
      };
      class cTab_microDAGR_RscMapControl: cTab_microDAGR_RscMapControl
      {
        REGISTER_FNC;
      };
      class cTab_Tablet_RscMapControl: cTab_Tablet_RscMapControl
      {
        REGISTER_FNC;
      };
      class cTab_TAD_RscMapControl: cTab_TAD_RscMapControl
      {
        REGISTER_FNC;
      };
      class cTab_TAD_RscMapControl_BLACK: cTab_TAD_RscMapControl_BLACK
      {
        REGISTER_FNC;
      };
      class cTab_android_RscMapControl: cTab_android_RscMapControl
      {
        REGISTER_FNC;
      };
    #endif */

  //- Mission Type
  class TaskType: RscCombo
  {
    REGISTER_FNC;

    idc = PROP_IDC(2107);
    colorBackground[] = {0,0,0,1};
    colorSelectBackground[] = {0.5,0.5,0.5,1};
    wholeHeight = 0.8;
    class Items
    {
      class 9line
      {
        text = "9 Line";
        textRight = "";
        value = 0;
        default = 1;
      };
      class 5line
      {
        text = "5 Line";
        textRight = "";
        value = 1;
      };
    };
  };

  //- Vehicle Group DropBox
  class Vehicle_Grp_Sel: RscCombo
  {
    REGISTER_FNC;

    idc = PROP_IDC(2001);
    wholeHeight = 0.8;
    font = "PuristaMedium";
    colorBackground[] = {0,0,0,1};
    colorSelect[] = {1,1,1,1};
    colorSelectBackground[] = {0.2,0.2,0.2,1};
    class Items
    {
      class NA
      {
        text = "NA";
        value = -1;
        default = 1;
      };   
    };
  };
  //-Description
  class taskDesc: RscStructuredText
  {
    REGISTER_FNC;

    idc = PROP_IDC(2004);
    text = "Desc :";
    colorBackground[] = {0,0,0,0};
    class Attributes
    {
      font = "RobotoCondensed_BCE";
      color = "#ffffff";
      align = "left";
      shadow = 1;
    };
  };
  class New_Task_Ctrl_Title: BCE_RscButtonMenu
  {
    idc = PROP_IDC(20110);
    style = 2;
    text = "$STR_BCE_ControlType_BNT";
    colorBackground[] = {0,0,0,0.4};
    show = 0;
    shadow = 1;
    periodFocus = 0;
    periodOver = 0;
    tooltip = "$STR_BCE_more_Details";
    onButtonClick = "call BCE_fnc_Extended_Desc";
    BCE_Desc = "$STR_BCE_DECS_sm_CtrlType";
    
    class Attributes
    {
      font = "RobotoCondensed_BCE";
      color = "#E5E5E5";
      align = "left";
      shadow = "true";
    };
  };

  //- Game Plan
    class New_Task_CtrlType: RscToolbox
    {
      REGISTER_FNC;

      idc = PROP_IDC(2011);
      rows = 1;
      columns = 3;
      strings[] =
      {
        "Type 1",
        "Type 2",
        "Type 3"
      };
      font = "RobotoCondensed_BCE";
      colorBackground[] = {0,0,0,0.3};
    };
    class New_Task_AttackType_Title: New_Task_Ctrl_Title
    {
      REGISTER_FNC;

      idc = PROP_IDC(20111);
      text = "$STR_BCE_AttackType_BNT";
      BCE_Desc = "$STR_BCE_DECS_sm_AttackType";
    };
    class New_Task_AttackType: New_Task_CtrlType
    {
      REGISTER_FNC;

      idc = PROP_IDC(20112);
      columns = 2;
      strings[] =
      {
        "BoT",
        "BoC"
      };
    };
    class New_Task_AttackType_Combo: TaskType
    {
      REGISTER_FNC;
      idc = PROP_IDC(20112);
      
      class Items
      {
        class BoT
        {
          text = "BoT";
          textRight = "";
          value = 0;
          default = 1;
        };
        class BoC
        {
          text = "BoC";
          textRight = "";
          value = 1;
        };
      };
    };
    class New_Task_Ordnance_Title: New_Task_Ctrl_Title
    {
      REGISTER_FNC;

      idc = PROP_IDC(20113);
      text = "$STR_BCE_OrdnanceREQ_BNT";
      BCE_Desc = "$STR_BCE_DECS_sm_Ordnance";
    };
    //- Weapon
      class AI_Remark_WeaponCombo: RscCombo
      {
        REGISTER_FNC;

        idc = PROP_IDC(2020);
      };
      class AI_Remark_ModeCombo: AI_Remark_WeaponCombo
      {
        REGISTER_FNC;

        idc = PROP_IDC(2021);
      };
      class Attack_Range_Combo: AI_Remark_ModeCombo
      {
        REGISTER_FNC;

        idc = PROP_IDC(2022);
        tooltip = "$STR_BCE_tip_Attack_Range";
        class Items
        {
          class 2000m
          {
            text = "2000m";
            value = 2000;
            default = 1;
          };
          class 1500m
          {
            text = "1500m";
            value = 1500;
          };
          class 1000m
          {
            text = "1000m";
            value = 1000;
          };
        };
      };
      class Round_Count_Box: RscEdit
      {
        REGISTER_FNC;

        idc = PROP_IDC(2023);
        Style = 2;
        text = "1";
        tooltip = "$STR_BCE_tip_Round_Count";
      };
      class Attack_Height_Box: Round_Count_Box
      {
        REGISTER_FNC;

        idc = PROP_IDC(2024);
        tooltip = "$STR_BCE_tip_Attack_Height";
        text = "2000";
      };
  
  //- IP
    class New_Task_IPtype: RscToolbox
    {
      REGISTER_FNC;

      idc = PROP_IDC(2012);
      
      shadow = 1;
      rows = 1;
      columns = 3;
      strings[] =
      {
        "$STR_BCE_Tit_Map_marker",
        "$STR_BCE_Tit_Click_Map",
        "$STR_BCE_Tit_OverHead"
      };
      
      font = "RobotoCondensed_BCE";
      colorBackground[] = {0,0,0,0.3};
      onToolBoxSelChanged = "call BCE_fnc_onTaskElementChange";
    };
    class New_Task_MarkerCombo: AI_Remark_WeaponCombo
    {
      REGISTER_FNC;

      idc = PROP_IDC(2013);
      wholeHeight = 0.8;
      font = "PuristaMedium";
      onMouseButtonClick = "(_this # 0) call BCE_fnc_IPMarkers";
      class Items
      {
        class NA
        {
          text = "$STR_BCE_SelectMarker";
          data = "[]";
          default = 1;
        };
      };
    };
    class New_Task_IPExpression: RscEdit
    {
      REGISTER_FNC;

      idc = PROP_IDC(2014);
      text = "";
      canModify = 0;
      colorBackground[] = {0,0,0,0};
      tooltip = "$STR_BCE_tip_ShowResult";
    };
  
  //- TG Description
    class New_Task_TGT: New_Task_IPtype
    {
      REGISTER_FNC;

      idc = PROP_IDC(20121);
      columns = 2;
      strings[] =
      {
        "$STR_BCE_Tit_Map_marker",
        "$STR_BCE_Tit_Click_Map"
      };
    };
    class New_Task_TG_DESC: RscEdit
    {
      REGISTER_FNC;

      idc = PROP_IDC(2015);
      text = "";
      tooltip="$STR_BCE_TIP_AddDESC";
    };
    class New_Task_TG_DESC_Combo: RscCombo
    {
      REGISTER_FNC;
      idc = PROP_IDC(2027);
      
      wholeHeight = 0.8;
      font = "PuristaMedium";
      tooltip = "$STR_BCE_TIP_DESC";
      
      style="0x10 + 0x200 + 0x02";
      colorText[] = {1,1,1,1};
      colorBackground[]={0,0,0,0.75};
      colorSelect[]={1,1,1,1};
      colorSelectBackground[]={0.2,0.2,0.2,1};
      
      class Items
      {
        class Custom
        {
          text = "$STR_BCE_DESC_Custom";
          textRight = "";
          value = 0;
          default = 1;
        };
        class Open
        {
          text = "$STR_BCE_DESC_Open";
          textRight = "";
          value = 1;
          color[]={0.65,0.65,0.65,1};
        };
        class Cover: Open
        {
          text = "$STR_BCE_DESC_Cover";
          value = 2;
        };
        class treeline: Open
        {
          text = "$STR_BCE_DESC_treeline";
          value = 3;
        };
        class Hardstructure: Open
        {
          text = "$STR_BCE_DESC_Hardstructure";
          value = 4;
        };
      };
    };

  //- Mark
    class New_Task_GRID_DESC: New_Task_IPExpression
    {
      REGISTER_FNC;

      idc = PROP_IDC(2016);
      canModify = 1;
      text = "$STR_BCE_MarkWith";
      tooltip = "";
    };
    class New_Task_GRID_DESC_Air_5line: New_Task_GRID_DESC
    {
      REGISTER_FNC;

      idc = PROP_IDC(20160);
    };
    class New_Task_FRND_DESC: New_Task_GRID_DESC
    {
      REGISTER_FNC;
      idc = PROP_IDC(2026);
    };

  //- ERGS
    class New_Task_EGRS_Azimuth: RscToolbox
    {
      REGISTER_FNC;

      idc = PROP_IDC(2017);
      rows = 1;
      columns = 8;
      strings[] =
      {
        "N",
        "NE",
        "E",
        "SE",
        "S",
        "SW",
        "W",
        "NW"
      };
      values[] =
      {
        0,
        45,
        90,
        135,
        180,
        225,
        270,
        315
      };
      font = "RobotoCondensed_BCE";
      colorBackground[] = {0,0,0,0.3};
    };
    class New_Task_EGRS_Bearing: New_Task_GRID_DESC
    {
      REGISTER_FNC;

      idc = PROP_IDC(2018);
      text = "$STR_BCE_Bearing_ENT";
    };
    class New_Task_EGRS: New_Task_IPtype
    {
      REGISTER_FNC;

      idc = PROP_IDC(2019);
      columns = 4;
      strings[] =
      {
        "$STR_BCE_Tit_Azimuth",
        "$STR_BCE_Tit_Bearing",
        "$STR_BCE_Tit_Map_marker",
        "$STR_BCE_Tit_OverHead"
      };
    };
    
  //- Remarks
    class New_Task_FADH: New_Task_IPtype
    {
      REGISTER_FNC;

      idc = PROP_IDC(2200);
      columns = 3;
      strings[] =
      {
        "FAD",
        "FAH",
        "$STR_BCE_Default"
      };
    };
    class New_Task_DangerClose_Text: RscText
    {
      REGISTER_FNC;

      idc = PROP_IDC(2201);
      text = ": Danger Close";
    };
    class New_Task_DangerClose_Box: RscCheckBox
    {
      REGISTER_FNC;

      idc = PROP_IDC(2202);
      textureChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
      textureFocusedChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
      textureHoverChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
      texturePressedChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
      textureDisabledChecked = "\a3\3DEN\Data\Controls\ctrlCheckbox\textureChecked_ca.paa";
    };
  //- CFF
    class TaskType_GND: TaskType
    {
      class Items
      {
        class CallForFire
        {
          text = "Adjust Fire";
          data = "ADJUST FIRE";
          textRight = "";
          // value = 0;
          default = 1;
        };
        class Suppress
        {
          text = "Suppress";
          data = "SUPPRESS";
          textRight = "";
          // value = 2;
        };
        class immediate_Suppress
        {
          text = "Immediate Suppress";
          data = "IMMEDIATE SUPPRESS";
          textRight = "";
          // value = 1;
        };
      };
    };
    
    //- In Effect (IE) Section
      class CFF_IE_WeaponCombo: AI_Remark_WeaponCombo
      {
        idc = PROP_IDC(1013);
        tooltip="$STR_BCE_Ammunition_Tip"; //- e.g. “ICM” (projectile) or “VT in effect” (fuze). The term, “in effect”
      };
      class CFF_IE_FuzeCombo: AI_Remark_ModeCombo
      {
        //- MT  : (Mechanical Time) - Time Fuze
        //- VT  : (Variable Time) - Proximity Fuze
        //- ICM : (Improved-Conventional-Munition) - Cluster
        idc = PROP_IDC(1015);
        tooltip="$STR_BCE_Ammunition_Fuze_Tip";
        class Items
        {
          class Impact
          {
            text = "IMPT";
            textRight = "";
            // value = 0;
            default = 1;
          };
          class VT
          {
            text = "VT";
            textRight = "";
            Data = "VT";
            value = 1;
          };
          class Delay
          {
            text = "DELY";
            textRight = "";
            Data = "DELAY";
            // value = -1;
          };
        };
      };
      class CFF_IE_FireUnit_Combo: AI_Remark_ModeCombo
      {
        REGISTER_FNC;

        idc = PROP_IDC(1014);
        tooltip = "$STR_BCE_CFF_FireUnit_Tip";
      };
      class CFF_IE_Round_Box: Round_Count_Box
      {
        idc = PROP_IDC(1016);
        text = "";
        tooltip="$STR_BCE_CFF_Round_Tip";
      };
      class CFF_IE_Radius_Box: Attack_Height_Box
      {
        idc = PROP_IDC(1017);
        tooltip="$STR_BCE_CFF_Radius_Tip";
        text = "150";
      };
      class CFF_IE_FuzeValue_Box: CFF_IE_Round_Box
      {
        idc = PROP_IDC(1018);
        tooltip="$STR_BCE_CFF_FuzeValue_Tip";
      };
      class CFF_IE_FireAngle_Bnt: BCE_RscButtonMenu
      {
        REGISTER_FNC;
        idc = PROP_IDC(1019);
        text = "";
        tooltip = "$STR_BCE_FireAngle_Tip";
        
        //- Style
          animTextureOver = "#(argb,8,8,3)color(1,1,1,0.75)";
          animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
          animTexturePressed = "#(argb,8,8,3)color(1,1,1,0.65)";

          colorBackground[] = 
          {
            "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
            0.8
          };
          colorBackground2[] = 
          {
            "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
            0.8
          };
          colorBackgroundFocused[] = 
          {
            "(profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
            "(profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
            0.5
          };
        
        class Attributes
        {
          font = "RobotoCondensed_BCE";
          color = "#E5E5E5";
          align = "center";
          shadow = "true";
          size = 0.9;
        };
      };
      /* class CFF_FireAngle_Combo: AI_Remark_ModeCombo
      {
        REGISTER_FNC;

        idc = PROP_IDC(1019);
        tooltip = "Angle of Fire";
        class Items
        {
          class low
          {
            text = "Low";
            textRight = "";
            value = 0;
            default = 1;
            tooltip = "Low Angle";
          };
          class high
          {
            text = "High";
            textRight = "";
            value = 1;
            tooltip = "High Angle";
          };
        };
      }; */
    //- In Adjust (IA) Section
      class CFF_IA_WeaponCombo: CFF_IE_WeaponCombo
      {
        idc = PROP_IDC(1113);
      };
      class CFF_IA_FuzeCombo: CFF_IE_FuzeCombo
      {
        idc = PROP_IDC(1114);
        onLBSelChanged = "(_this+[0]) call BCE_fnc_onTaskElementChange";
        class Items: Items
        {
          class Empty
          {
            text = "--";
            textRight = "";
            value = -1;
            default = 1;
          };
          class Impact: Impact{};
          class VT: VT{};
          class Delay: Delay{};
        };
      };
      class CFF_IA_FireUnit_Combo: CFF_IE_FireUnit_Combo
      {
        idc = PROP_IDC(1115);
      };
      class CFF_IA_Round_Box: CFF_IE_Round_Box
      {
        idc = PROP_IDC(1116);
      };
      class CFF_IA_FuzeValue_Box: CFF_IE_FuzeValue_Box
      {
        idc = PROP_IDC(1118);
      };
    
    class New_Task_CFF_OT_Info: New_Task_IPtype
    {
      REGISTER_FNC;

      idc = PROP_IDC(2205);
      
      columns = 2;
      strings[] =
      {
        "GRID",
        "POLAR"
      };
      tooltips[] =
      {
        "$STR_BCE_CFF_OT_INFO_GRID_Tip",
        "$STR_BCE_CFF_OT_INFO_POLAR_Tip" //- Observer can be other FOs
      };
    };
    class New_Task_CFF_CtrlType: New_Task_IPtype
    {
      REGISTER_FNC;

      idc = PROP_IDC(2203);
      strings[] =
      {
        "At-Ready",
        "TOT",
        "AMC"
      };
      class BCE_Data
      {
        functions[] =
        {
          "BCE_fnc_CFF_AT_READY",
          "BCE_fnc_CFF_TOT",
          "BCE_fnc_CFF_AMC"
        };
      };
      tooltips[] =
      {
        "$STR_BCE_CFF_CtrlType_AT_READY_Tip",
        "$STR_BCE_CFF_CtrlType_TOT_Tip",
        "$STR_BCE_CFF_CtrlType_AMC_Tip"
      };
    };
    class New_Task_CFF_TOT: New_Task_EGRS_Bearing
    {
      REGISTER_FNC;

      idc = PROP_IDC(2204);
      text = "$STR_BCE_CFF_TOT_INPUT";
    };
    class New_Task_CFF_StructText: taskDesc
    {
      REGISTER_FNC;

      idc = PROP_IDC(2205);
      colorBackground[] = {0,0,0,0.3};
      text = "ETA TOF : 1m20s";
    };

    /* class New_Task_Submit_CFF_Mission_Type: RscToolbox
    {
      REGISTER_FNC;
      idc = PROP_IDC(2206);
      
      shadow = 2;
      rows = 1;
      columns = 2;
      strings[] =
      {
        "SUBMIT",
        "SUB & EXEC"
      };
      tooltips[] =
      {
        "",
        ""
      };
      colorBackground[] = {0,0,0,0.3};
    };
    class New_Task_Submit_CFF_Mission: BCE_RscButtonMenu
    {
      REGISTER_FNC;
      idc = PROP_IDC(2207);
      text = "<img image='\MG8\AVFEVFX\data\explosion.paa' /> Press To XMIT";
      onButtonClick = "call BCE_fnc_CFF_Mission_XMIT";
      
      //- Style
        animTextureOver = "#(argb,8,8,3)color(1,1,1,0.75)";
        animTextureFocused = "#(argb,8,8,3)color(1,1,1,1)";
        animTexturePressed = "#(argb,8,8,3)color(1,1,1,0.65)";

        colorBackground[] = 
        {
          0.45,0,0,0.8
        };
        colorBackground2[] = 
        {
          0.45,0,0,0.8
        };
        colorBackgroundFocused[] = 
        {
          0.45,0,0,0.5
        };
    }; */
    class New_Task_Adjust_Method_CFF: RscToolbox
    {
      REGISTER_FNC;
      idc = PROP_IDC(2208);
      shadow = 2;
      rows = 1;
      columns = 3;
      strings[] =
      {
        "POLAR",
        "IMPACT",
        "GUN-LINE"
      };
      tooltips[] =
      {
        "",
        "",
        ""
      };
      colorBackground[] = {0,0,0,0.3};
			class BCE_Data
			{
				//- #LINK - functions/CAS_Menu/Call_for_Fire/fn_set_FireAdjustValues.sqf
				AdjustTypes[] = {"POLAR","IMPACT","GUNLINE"};
				Default[] = {
					{"0,0",1},
					{"0","0"},
					{"0,0",1}
				};
			};
    };
    class New_Task_MissionType_ADJUST_CFF: New_Task_Adjust_Method_CFF
    {
      REGISTER_FNC;
      idc = PROP_IDC(2209);
      shadow = 2;
      rows = 1;
      columns = 2;
      strings[] =
      {
        "$STR_BCE_CFF_AF_TITLE",
        "$STR_BCE_CFF_FFE_TITLE"
      };
      tooltips[] =
      {
        "$STR_BCE_CFF_AF_Tip",
        "$STR_BCE_CFF_FFE_Tip"
      };
      colorBackground[] = {0,0,0,0.5};
    }; 
    class New_Task_MTO_Display: RscStructuredText
    {
      REGISTER_FNC;
      idc = PROP_IDC(2210);
      colorBackground[] = {0,0,0,0.3};
			tooltip = "$STR_BCE_CFF_MTO_Tip";
      class Attributes
      {
        font = "RobotoCondensed_BCE";
        valign="middle";
      };
    };
    class New_Task_OtherInfo_Display: New_Task_MTO_Display
    {
      REGISTER_FNC;
      idc = PROP_IDC(2211);
      colorBackground[] = {0,0,0,0.5};
    };
    class New_Task_IE_Sheaf_Mode: New_Task_IPtype
    {
      REGISTER_FNC;
      idc = PROP_IDC(2212);
      columns = 4;
      strings[] =
      {
        "STAND",  // No input = 100m
        "OPEN",   // Cycle radius > 100m
        "LINEAR", // Length/Width
        "POINT"   // No input
      };
      tooltips[] =
      {
        "",
        "",
        "",
        ""
      };
      class BCE_Data
      {
        modes[] = {
          "$STR_BCE_CFF_SHEAF_STD",
          "$STR_BCE_CFF_SHEAF_OPEN",
          "$STR_BCE_CFF_SHEAF_LINEAR",
          "$STR_BCE_CFF_SHEAF_POINT"
        };
      };
    };
    class New_Task_IE_Sheaf_LINE_L: CFF_IE_Radius_Box
    {
      REGISTER_FNC;
      idc = PROP_IDC(2213);
      tooltip = "$STR_BCE_CFF_SHEAF_LINEAR_A_Tip";
    };
    class New_Task_IE_Sheaf_LINE_W: New_Task_IE_Sheaf_LINE_L
    {
      REGISTER_FNC;
      idc = PROP_IDC(2214);
      tooltip = "$STR_BCE_CFF_SHEAF_LINEAR_B_Tip";
    };
    class New_Task_IE_Sheaf_LINE_Mil: New_Task_IE_Sheaf_LINE_L
    {
      REGISTER_FNC;
      idc = PROP_IDC(2215);
      tooltip = "$STR_BCE_CFF_SHEAF_LINEAR_D_Tip";
    };
    class New_Task_IE_Sheaf_LINE_L_T: RscText
    {
      REGISTER_FNC;
      idc = PROP_IDC(2216);
      shadow = 2;
      style = 2;
      
      text = "A";
      tooltip = "$STR_BCE_CFF_SHEAF_LINEAR_A_Tip";

      colorText[]={1,0.737255,0.0196078,1};
      colorBackground[] = {0,0,0,0};
    };
    class New_Task_IE_Sheaf_LINE_W_T: New_Task_IE_Sheaf_LINE_L_T
    {
      REGISTER_FNC;
      idc = PROP_IDC(2217);

      text = "B";
      tooltip = "$STR_BCE_CFF_SHEAF_LINEAR_B_Tip";
    };
    class New_Task_IE_Sheaf_LINE_Dir_T: New_Task_IE_Sheaf_LINE_L_T
    {
      REGISTER_FNC;
      idc = PROP_IDC(2218);

      text = "D";
      tooltip = "$STR_BCE_CFF_SHEAF_LINEAR_D_Tip";
    };

    //- SUPPRESSION Description
    class New_Task_SUP_DESC_Checkboxes: ctrlCheckboxes
    {
      REGISTER_FNC;
      idc = PROP_IDC(2219);
      style = 2;
      shadow = 2;
      rows = 1;
      columns = 3;
			font = "RobotoCondensed_BCE";
      strings[] = {"$STR_BCE_CFF_SUP_DURATION_X","$STR_BCE_CFF_SUP_ROUNDS_X","$STR_BCE_CFF_SUP_INTERVAL_X"};
      checked_strings[] = {"$STR_BCE_CFF_SUP_DURATION_O","$STR_BCE_CFF_SUP_ROUNDS_O","$STR_BCE_CFF_SUP_INTERVAL_O"};
      tooltips[] = {"$STR_BCE_CFF_SUP_DURATION_Tip","$STR_BCE_CFF_SUP_ROUNDS_Tip","$STR_BCE_CFF_SUP_INTERVAL_Tip"};
    };
    class New_Task_SUP_DESC_Duration: New_Task_GRID_DESC
    {
      REGISTER_FNC;
      idc = PROP_IDC(2220);
      text = ""; //- In minutes
      tooltip = "$STR_BCE_CFF_SUP_DURATION_Tip";
    };
    class New_Task_SUP_RND_Interval: New_Task_SUP_DESC_Duration
    {
      REGISTER_FNC;
      idc = PROP_IDC(2221);
      text = ""; //- foreach Tube each round In Seconds/Minutes (min 10 seconds)
      tooltip = "$STR_BCE_CFF_SUP_ROUNDS_Tip";
    };
    class New_Task_SUP_DESC_Interval: New_Task_SUP_DESC_Duration
    {
      REGISTER_FNC;
      idc = PROP_IDC(2222);
      text = "";
      tooltip = "$STR_BCE_CFF_SUP_INTERVAL_Tip";
    };
    class New_Task_SUP_DESC_SkipAdjust: New_Task_SUP_DESC_Checkboxes
    {
      REGISTER_FNC;
      idc = PROP_IDC(2223);

      columns = 1;
      strings[] = {"$STR_BCE_CFF_SUP_SKIP_AF_X"};
      checked_strings[] = {"$STR_BCE_CFF_SUP_SKIP_AF_O"};
      tooltips[] = {"$STR_BCE_CFF_SUP_SKIP_AF_Tip"};

      colorSelectedBg[] = {0.5,0,0,0.3};
    };
    class New_Task_SUP_DESC_MinSec: New_Task_SUP_DESC_Checkboxes
    {
      REGISTER_FNC;
      idc = PROP_IDC(2224);

      columns = 1;
      strings[] = {"$STR_BCE_MINUTE_Short"};
      checked_strings[] = {"$STR_BCE_SECOND_Short"};
      tooltips[] = {"$STR_BCE_CFF_SUP_INTERVAL_Unit_Tip"};
      
      colorBackground[] = 
      {
        "1 - (profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
        "1 - (profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
        "1 - (profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
        0.3
      };
      colorSelectedBg[] = {
        "1 - (profilenamespace getvariable ['GUI_BCG_RGB_R',0.13])",
        "1 - (profilenamespace getvariable ['GUI_BCG_RGB_G',0.54])",
        "1 - (profilenamespace getvariable ['GUI_BCG_RGB_B',0.21])",
        0.3
      };
    };
    class New_Task_CFF_SHEAF_StructText: New_Task_CFF_StructText
    {
      REGISTER_FNC;
      idc = PROP_IDC(2225);
			tooltip = "$STR_BCE_EFFECTIVE_RADIUS";
    };
    class New_Task_CFF_SUP_StructText: New_Task_CFF_StructText
    {
      REGISTER_FNC;
      idc = PROP_IDC(2226);
    };
    class New_Task_Expression_CFF: New_Task_IPExpression
    {
      REGISTER_FNC;
      idc = PROP_IDC(2227);
      style = 2;
      colorText[] = {0.8,0.8,0.8,1};
      tooltip = "$STR_BCE_CFF_Output_Expression_Tip";
    };
};

#undef PROP_IDC_OFFSET
#undef PROP_IDC
#undef REGISTER_FNC