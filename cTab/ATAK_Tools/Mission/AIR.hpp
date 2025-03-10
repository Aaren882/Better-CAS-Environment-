////////// 9 Line //////////
class AIR_9_LINE: ATAK_AppMenu_Base
{
    y = CATEGORY_H * ATAK_POS_H;
    h = phoneSizeH - ((CATEGORY_H + 0.75) * ATAK_POS_H);
    class controls
    {
        //- Background
            class Background: RscBackground
            {
                ATAK_POS(0,0,0,(0.7 + 12.7 + 0.35));
            };
        class Game_Plan_T: RscText
        {
            idc = -1;
            shadow=2;
            text="Game Plan";
            sizeEx = TextSize;
            ATAK_POS(0,0,1,1);
            font = "RobotoCondensed_BCE";
            colorBackground[] = {0,0,0,0};
            colorText[]={1,0.737255,0.0196078,1};
            tooltip="$STR_BCE_TIP_GAMEPLAN";
        };
        //-Task Type
        class TaskType: RscCombo
        {
            idc = idc_D(2107);
            ATAK_POS(1,((0.35/2)),1.9,0.65);
            
            wholeHeight = 0.8;
            sizeEx = 0.9 * TextSize;
            font = "PuristaMedium";
            
            colorBackground[] = {0,0,0,1};
            colorSelect[]={1,1,1,1};
            colorSelectBackground[]={0.2,0.2,0.2,1};
            
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

        class CtrlType: Game_Plan_T
        {
            text="Type";
            ATAK_POS(0,(1.1),1,0.8);
            tooltip="$STR_BCE_TIP_CtrlType";
        };

        //-MOA
        class New_Task_CtrlType: RscToolbox
        {
            idc = idc_D(2011);
            ATAK_POS(0.5,(1 + (0.35/2)),1.2,0.65);
            rows = 1;
            columns = 3;
            strings[] =
            {
                "T1",
                "T2",
                "T3"
            };
            onToolBoxSelChanged = "call BCE_fnc_ATAK_AutoSaveTask";
            font = "RobotoCondensed_BCE";
            colorBackground[] = {0,0,0,0.3};
            sizeEx = 0.9 * TextSize;
        };
        class MOA_T: Game_Plan_T
        {
            text="MOA";
            sizeEx = 0.85 * TextSize;
            ATAK_POS(1.8,(1 + (0.35/2)),0.4,0.65);
            tooltip="$STR_BCE_TIP_MOA";
        };
        class MOA_Combo: TaskType
        {
            idc = idc_D(20112);
            ATAK_POS(2.2,(1 + (0.35/2)),0.7,0.65);
            
            colorBackground[] = {0.3,0.3,0.3,1};
            colorSelect[]={1,1,1,1};
            colorSelectBackground[]={0.4,0.4,0.4,1};
            
            onLBSelChanged = "call BCE_fnc_ATAK_AutoSaveTask";
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

        //-Weapons Selections
        class Weapon_T: CtrlType
        {
            text="Weapon";
            ATAK_POS(0,(2 + (0.35/2)),1,0.63);
            tooltip="$STR_BCE_TIP_Weapon";
        };
        class AI_Remark_WeaponCombo: MOA_Combo
        {
            idc = idc_D(2020);
            ATAK_POS(0.7,(2 + (0.35/2)),1.5,0.65);
            sizeEx = 0.9 * TextSize;
            onLBSelChanged = "(_this + [17000]) call BCE_fnc_CAS_SelWPN; call BCE_fnc_ATAK_AutoSaveTask;";
            class Items{};
        };
        class AI_Remark_ModeCombo: AI_Remark_WeaponCombo
        {
            idc = idc_D(2021);
            ATAK_POS(2.2,(2 + (0.35/2)),0.7,0.63);
            onLBSelChanged = "call BCE_fnc_ATAK_AutoSaveTask";
        };
        class Attack_Range_Combo: AI_Remark_ModeCombo
        {
            idc = idc_D(2022);
            ATAK_POS(0.7,(2.65 + (0.35/2)),1.1,0.63);
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
            idc = idc_D(2023);
            ATAK_POS(1.8,(2.65 + (0.35/2)),(1.1/3),0.63);
            Style = 2;
            text = "1";
            sizeEx = 0.9 * TextSize;
            tooltip = "$STR_BCE_tip_Round_Count";
            onEditChanged = "call BCE_fnc_ATAK_AutoSaveTask";
        };
        class Attack_Height_Box: Round_Count_Box
        {
            idc = idc_D(2024);
            ATAK_POS((1.8 + (1.1/3)),(2.65 + (0.35/2)),(2.2/3),0.63);
            tooltip = "$STR_BCE_tip_Attack_Height";
            text = "2000";
        };

        //-1~3 lines
        class IP2TG_T9: CtrlType
        {
            idc = 93;
            text="1-3";
            ATAK_POS(0,(3.6 + (0.35/2)),1,0.7);
            tooltip="$STR_BCE_TIP_IPBP_Info";
        };
        class IP2TG_EditBnt: BCE_RscButtonMenu
        {
            idc = idc_D(2025);
            ATAK_POS(0.4,(3.6 + (0.35/2)),2.5,0.7);
            sizeEx = TextSize;
            text = "T1 , 360° , 1200m";
            tooltip="$STR_BCE_TIP_IPBP_Info";
            
            //-Style
            colorBackground[] = {0,0,0,0.5};
            colorBackground2[] = {0,0,0,0};
            colorBackgroundFocused[] = {0,0,0,0};

            animTextureDefault="#(argb,8,8,3)color(0,0,0,0.8)";
            animTextureNormal="#(argb,8,8,3)color(0,0,0,0.8)";
            animTextureOver = "#(argb,8,8,3)color(0,0,0,0.5)";
            animTextureFocused = "#(argb,8,8,3)color(0,0,0,0.8)";
            animTexturePressed = "#(argb,8,8,3)color(0,0,0,0.3)";

            size = 0.7 * (((60) - (20))) / 2048 * CustomPhoneH;
            
            onButtonClick = "[nil,'Task_Building',1] call BCE_fnc_ATAK_ChangeTool;";
            
            class Attributes: Attributes
            {
                align = "center";
                font = "RobotoCondensedBold_BCE";
                size = TextMenu(1);
            };
            class TextPos
            {
                left = 0.25 * (((safezoneW / safezoneH) min 1.2) / 40) / TextTimesH;
                top = 0.25 * (((safezoneW / safezoneH) min 1.2) / 40) / TextTimesH;
                right = 0;
                bottom = 0;
            };
        };

        //-Line 4
        class Line4_T9: CtrlType
        {
            idc = 94;
            text="4";
            ATAK_POS(0,(4.6 + (0.35/2)),1,0.7);
            tooltip="$STR_BCE_TIP_ELEV";
        };
        class L94_EditBnt: IP2TG_EditBnt
        {
            idc = idc_D(2026);
            ATAK_POS(0.2,(4.6 + (0.35/2)),2.7,0.7);
            text = "535ft MSL";
            tooltip="$STR_BCE_TIP_ELEV";
            onButtonClick = "[nil,'Task_Building',4] call BCE_fnc_ATAK_ChangeTool;";
        };
        /*class L94_PullBnt: ctrlButton
        {
            idc = idc_D(20260);
            ATAK_POS(2.55,(4.6 + (0.35/2)),0.35,0.7);
            
            style = "0x02 + 0x30 + 0x800";
            colorBackground[] = {0.1,0.1,0.1,0.75};
            sizeEx = 0.85 * TextSize;
            
            tooltip = "Show Info";
            text = "\a3\ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa";
            action = "4 call BCE_fnc_ATAK_PullData";
        };*/

        //-Line 5
        class Line5_T9: CtrlType
        {
            idc = 95;
            text="5";
            ATAK_POS(0,(5.6 + (0.35/2)),1,0.7);
            tooltip="$STR_BCE_TIP_DESC";
        };
        //-Task Type
        class L95_EditBnt: RscCombo
        {
            idc = idc_D(2027);
            ATAK_POS(0.2,(5.6 + (0.35/2)),2.3,0.7);
            
            wholeHeight = 0.8;
            sizeEx = 0.9 * TextSize;
            font = "PuristaMedium";
            tooltip="$STR_BCE_TIP_DESC";
            
            style="0x10 + 0x200 + 0x02";
            colorText[] = {1,1,1,1};
            colorBackground[]={0,0,0,0.75};
            colorSelect[]={1,1,1,1};
            colorSelectBackground[]={0.2,0.2,0.2,1};
            
            onLBSelChanged = "call BCE_fnc_ATAK_DescType_Changed";
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
        class L95_DESC: RscEdit
        {
            idc = idc_D(2015);
            sizeEx = 0.9 * TextSize;
            ATAK_POS(0.15,(6.5 + (0.35/2)),2.75,0.7);
            
            colorText[] = {0.75,0.75,0.75,1};
            colorBackground[]={0,0,0,0.5};
            tooltip="$STR_BCE_TIP_AddDESC";
            onEditChanged = "(_this + [0]) call BCE_fnc_ATAK_AutoSaveTask";
        };
        class L95_PullBnt: ctrlButton
        {
            idc = idc_D(20260);
            ATAK_POS(2.55,(5.6 + (0.35/2)),0.35,0.7);
            
            style = "0x02 + 0x30 + 0x800";
            colorBackground[] = {0.1,0.1,0.1,0.75};
            sizeEx = 0.85 * TextSize;
            
            tooltip = "$STR_BCE_ATAK_Show_Info";
            text = "\a3\ui_f\data\GUI\RscCommon\RscButtonSearch\search_start_ca.paa";
            action = "6 call BCE_fnc_ATAK_PullData";
        };

        //-Line 6
        class Line6_T9: CtrlType
        {
            idc = 96;
            text="6";
            ATAK_POS(0,(7.6 + (0.35/2)),1,0.7);
            tooltip="$STR_BCE_TIP_GRID";
        };
        class L96_EditBnt: IP2TG_EditBnt
        {
            idc = idc_D(2029);
            ATAK_POS(0.2,(7.6 + (0.35/2)),2.7,0.7);
            text = "XT 123456";
            tooltip="$STR_BCE_TIP_GRID";
            onButtonClick = "[nil,'Task_Building',6] call BCE_fnc_ATAK_ChangeTool;";
        };

        //-Line 7
        class Line7_T9: CtrlType
        {
            idc = 97;
            text="7";
            ATAK_POS(0,(8.6 + (0.35/2)),1,0.7);
            tooltip="$STR_BCE_TIP_MARK";
        };
        class L97_EditBnt: IP2TG_EditBnt
        {
            idc = idc_D(2030);
            ATAK_POS(0.2,(8.6 + (0.35/2)),2.7,0.7);
            text = "NO MARKS";
            tooltip="$STR_BCE_TIP_MARK";
            onButtonClick = "[nil,'Task_Building',7] call BCE_fnc_ATAK_ChangeTool;";
        };

        //-Line 8
        class Line8_T9: CtrlType
        {
            idc = 98;
            text="8";
            ATAK_POS(0,(9.6 + (0.35/2)),1,0.7);
            tooltip="$STR_BCE_TIP_FRND";
        };
        class L98_EditBnt: IP2TG_EditBnt
        {
            idc = idc_D(2031);
            ATAK_POS(0.2,(9.6 + (0.35/2)),2.7,0.7);
            text = "None";
            tooltip="$STR_BCE_TIP_FRND";
            onButtonClick = "[nil,'Task_Building',8] call BCE_fnc_ATAK_ChangeTool;";
        };
        //-Line 9
        class Line9_T9: CtrlType
        {
            idc = 99;
            text="9";
            ATAK_POS(0,(10.6 + (0.35/2)),1,0.7);
            tooltip="$STR_BCE_TIP_EGRS";
        };
        class L99_EditBnt: IP2TG_EditBnt
        {
            idc = idc_D(2032);
            ATAK_POS(0.2,(10.6 + (0.35/2)),2.7,0.7);
            text = "Back To IP";
            tooltip="$STR_BCE_TIP_EGRS";
            onButtonClick = "[nil,'Task_Building',9] call BCE_fnc_ATAK_ChangeTool;";
        };

        ////// -Separator for Remarks //////
        class Separator: cTab_RscFrame
        {
            ATAK_POS(0.1,(11.65 + (0.35/2)),2.8,0.001);
        };

        class Remark: Game_Plan_T
        {
            text="Remarks/Restrictions";
            ATAK_POS(0.1,(11.7 + (0.35/2)),2.9,1);
            sizeEx = 0.9 * TextSize;
            font = "RobotoCondensedBold_BCE";
            tooltip="$STR_BCE_TIP_Remarks";
        };

        class Remark_EditBnt: IP2TG_EditBnt
        {
            idc = 3002;
            ATAK_POS(0.1,(12.7 + (0.35/2)),2.8,0.7);
            text = "No Remarks";
            tooltip="$STR_BCE_TIP_Remarks";
            onButtonClick = "[nil,'Task_Building',10] call BCE_fnc_ATAK_ChangeTool;";
        };
        
        /*class AddRemark: ctrlButton
        {
            idc=3002;
            ATAK_POS((2.4+0.15/2),(11.8 + (0.35/2)),0.4,0.7);
            
            style = "0x02 + 0x30 + 0x800";
            colorBackground[] = {0,0,0,0.3};
            sizeEx = 0.85 * TextSize;
            
            tooltip = "$STR_BCE_TIP_AddRemark";
            text = "a3\3den\data\displays\display3den\panelleft\entitylist_layer_ca.paa";
            
            onButtonClick = "call BCE_fnc_ATAK_addRemark";
        };*/
    };
};

////////// 5 Line //////////
class AIR_5_LINE: AIR_9_LINE
{
    class controls: controls
    {
        //- Inherits
            class Background: Background
            {
                ATAK_POS(0,0,0,(0.7 + 10.3 + 0.35));
            };
            class Game_Plan_T: Game_Plan_T {};
            class TaskType: TaskType {};
            class CtrlType: CtrlType {};
            class New_Task_CtrlType: New_Task_CtrlType {};
            class MOA_T: MOA_T {};
            class MOA_Combo: MOA_Combo {};
            class Weapon_T: Weapon_T {};
            class AI_Remark_WeaponCombo: AI_Remark_WeaponCombo {};
            class AI_Remark_ModeCombo: AI_Remark_ModeCombo {};
            class Attack_Range_Combo: Attack_Range_Combo {};
            class Round_Count_Box: Round_Count_Box {};
            class Attack_Height_Box: Attack_Height_Box {};
        
        class Line1_T5: CtrlType
        {
            text="1";
            ATAK_POS(0,(3.6 + (0.35/2)),1,0.7);
            tooltip="$STR_BCE_TIP_5Line";
        };
        class L51_EditBnt: RscStructuredText
        {
            idc = idc_D(2040);
            style = 2;
            ATAK_POS(0.2,(3.6 + (0.35/2)),2.7,0.7);
            colorBackground[] = {0.2,0.2,0.2,0.5};
            
            // size = ((((safezoneW / safezoneH) min 1.2) / 1.2) / 25) / TextTimesH;
            size = TextSize;
            text = "“Alpha 1-1” / “Alpha 1-2”";
            tooltip="$STR_BCE_TIP_5Line";
            
            class Attributes
            {
                align = "center";
                // valign = "middle";
                font = "RobotoCondensedBold_BCE";
                size = TextMenu(0.8);
            };
        };

        class Line2_T5: CtrlType
        {
            text="2";
            ATAK_POS(0,(4.6 + (0.35/2)),1,0.7);
            tooltip="$STR_BCE_TIP_FRND";
        };
        class L52_EditBnt: IP2TG_EditBnt
        {
            idc = idc_D(2041);
            ATAK_POS(0.2,(4.6 + (0.35/2)),2.7,0.7);
            text = "None";
            tooltip="$STR_BCE_TIP_FRND";
            onButtonClick = "[nil,'Task_Building',1] call BCE_fnc_ATAK_ChangeTool";
        };

        class Line3_T5: CtrlType
        {
            text="3";
            ATAK_POS(0,(5.6 + (0.35/2)),1,0.7);
            tooltip="$STR_BCE_TIP_GRID";
        };
        class L53_EditBnt: IP2TG_EditBnt
        {
            idc = idc_D(2042);
            ATAK_POS(0.2,(5.6 + (0.35/2)),2.7,0.7);
            text = "None";
            tooltip="$STR_BCE_TIP_GRID";
            onButtonClick = "[nil,'Task_Building',2] call BCE_fnc_ATAK_ChangeTool;";
        };

        class Line4_T5: CtrlType
        {
            text="4";
            ATAK_POS(0,(6.6 + (0.35/2)),1,0.7);
            tooltip="$STR_BCE_TIP_DESC";
        };
        class L54_EditBnt: L95_EditBnt
        {
            ATAK_POS(0.2,(6.6 + (0.35/2)),2.3,0.7);
            tooltip="$STR_BCE_TIP_DESC";
        };
        class L54_PullBnt: L95_PullBnt
        {
            idc = idc_D(20430);
            ATAK_POS(2.55,(6.6 + (0.35/2)),0.35,0.7);
            action = "2 call BCE_fnc_ATAK_PullData";
        };

        //-Text EditBox
        class New_Task_TG_DESC: L95_DESC
        {
            ATAK_POS(0.15,(7.5 + (0.35/2)),2.75,0.7);
        };
        class New_Task_GRID_DESC: L95_DESC
        {
            idc = idc_D(2016);
            ATAK_POS(0.15,(8.2 + (0.35/2)),2.75,0.7);
            
            text = "$STR_BCE_MarkWith";
            tooltip="";
            onEditChanged = "(_this + [1]) call BCE_fnc_ATAK_AutoSaveTask";
        };

        ////// Separator for Remarks //////
        class Separator: Separator
        {
            ATAK_POS(0.1,(9.25 + (0.35/2)),2.8,0.001);
        };

        class Remark: Remark
        {
            ATAK_POS(0.1,(9.3 + (0.35/2)),2.9,1);
        };

        class Remark_EditBnt: Remark_EditBnt
        {
            ATAK_POS(0.1,(10.3 + (0.35/2)),2.8,0.7);
        };
    };
};