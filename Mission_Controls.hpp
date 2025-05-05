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
    class New_Task_Ctrl_Title: RscButtonMenu
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
                    value = 0;
                    default = 1;
                };
                class Suppress
                {
                    text = "Suppress";
                    data = "SUPPRESS";
                    textRight = "";
                    value = 1;
                };
                class immediate_Suppress
                {
                    text = "Immediate Suppress";
                    data = "IMMEDIATE SUPPRESS";
                    textRight = "";
                    value = 2;
                };
            };
        };
        
        //- In Effect (IE) Section
            class CFF_IE_WeaponCombo: AI_Remark_WeaponCombo
            {
                idc = PROP_IDC(1013);
                tooltip="Ammunition"; //- e.g. “ICM” (projectile) or “VT in effect” (fuze). The term, “in effect”
            };
            class CFF_IE_FuzeCombo: AI_Remark_ModeCombo
            {
                //- MT  : (Mechanical Time) - Time Fuze
                //- VT  : (Variable Time) - Proximity Fuze
                //- ICM : (Improved-Conventional-Munition) - Cluster
                idc = PROP_IDC(1015);
                tooltip="The Ammunition Fuze";
                class Items
                {
                    class Impact
                    {
                        text = "IMPT";
                        textRight = "";
                        value = 0;
                        default = 1;
                    };
                    class VT
                    {
                        text = "VT";
                        textRight = "";
                        value = 1;
                    };
                    class Delay
                    {
                        text = "DELY";
                        textRight = "";
                        value = 2;
                    };
                };
            };
            class CFF_IE_FireUnit_Combo: AI_Remark_ModeCombo
            {
                REGISTER_FNC;

                idc = PROP_IDC(1014);
                tooltip = "Unit(s) to fire";
            };
            class CFF_IE_Round_Box: Round_Count_Box
            {
                idc = PROP_IDC(1016);
                tooltip="Rounds to fire for each Unit";
            };
            class CFF_IE_Radius_Box: Attack_Height_Box
            {
                idc = PROP_IDC(1017);
                tooltip="Impact Radius when ""Fire for Effect""";
            };
            class CFF_IE_FuzeValue_Box: CFF_IE_Round_Box
            {
                idc = PROP_IDC(1018);
                tooltip="Fuze Value";
            };
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
            class CFF_IA_Radius_Box: CFF_IE_Radius_Box
            {
                idc = PROP_IDC(1117);
                tooltip="Impact Radius for ""Adjust Fire""";
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
                "Target GRID",
                "POLAR from Observer to Target" //- Observer can be other FOs
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
            tooltips[] =
            {
                "Fire When Ready",
                """Impact"" Time on Target",
                "At My Command"
            };
        };
        class New_Task_CFF_TOT: New_Task_EGRS_Bearing
        {
            REGISTER_FNC;

            idc = PROP_IDC(2204);
            text = "Enter Minutes...";
        };
        class New_Task_CFF_ETA: taskDesc
        {
            REGISTER_FNC;

            idc = PROP_IDC(2205);
            colorBackground[] = {0,0,0,0.3};
            text = "ETA TOF : 1m20s";
        };

        class New_Task_Submit_CFF_Mission_Type: RscToolbox
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
        };
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
                "ADJUST FIRE",
                "FIRE FOR EFFECT"
            };
            tooltips[] =
            {
                "",
                ""
            };
            colorBackground[] = {0,0,0,0.5};
            onToolBoxSelChanged = "['MSN_STATE',_this#1] call BCE_fnc_set_FireAdjust_MSN_State";
        }; 
        class New_Task_MTO_Display: RscStructuredText
        {
            REGISTER_FNC;
            idc = PROP_IDC(2210);
            colorBackground[] = {0,0,0,0.3};
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
};

#undef PROP_IDC_OFFSET
#undef PROP_IDC
#undef REGISTER_FNC